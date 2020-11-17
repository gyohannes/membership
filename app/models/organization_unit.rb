class OrganizationUnit < ApplicationRecord
  belongs_to :organization_type
  belongs_to :parent_organization_unit, optional: true, :class_name => 'OrganizationUnit', :foreign_key => "parent_organization_unit_id"
  has_many :sub_organization_units, :class_name => 'OrganizationUnit', :foreign_key => "parent_organization_unit_id"
  has_many :users
  has_many :people
  has_many :trainings
  has_many :trainee_distributions
  has_many :support_requests

  validates :name, :short_name, :organization_type_id, presence: true
  validates :parent_organization_unit_id, presence: true, if: :top_organization_unit_exists?

  def self.regions
    joins(:organization_type).where(organization_types: {name: 'Region'})
  end

  def self.zones
    joins(:organization_type).where(organization_types: {name: 'Zone'})
  end

  def self.woredas
    joins(:organization_type).where(organization_types: {name: 'Woreda'})
  end

  def trainee_distribution(training)
    trainee_distributions.where('training_id = ?', training).first
  end

  def assigned_number_of_trainees(training)
    training.trainee_distributions.where('organization_unit_id = ?', self.id).pluck('number_of_trainees').sum
  end
  def all_trainings(from=nil,to=nil)
    trainings = self.trainings + Training.joins(:trainee_distributions).
        where('trainee_distributions.organization_unit_id = ?',self.id)
    unless from.blank? and to.blank?
      trainings = trainings.where('start_time >= ? and start_time <= ?',from, to)
    end
    return (trainings + sub_trainings(from,to)).uniq
  end

  def sub_trainings(from=nil,to=nil)
    trainings = []
    sub_units.each do |su|
      trainings << su.all_trainings(from,to)
    end
    return trainings.uniq.flatten
  end

  def sub_unit_name
      sub_organization_units.joins(:organization_type).pluck('organization_types.name').uniq
  end

  def trainees
    sub_people.joins(:trainees)
  end

  def top_organization_unit_exists?
    ![OrganizationUnit.top_organization_unit].reject{|x| x == self || x.blank?}.blank?
  end
  
  def self.top_organization_unit
    where('parent_organization_unit_id is null').first
  end

  def self.organization_tree(user)
    parent = user.try(:organization_unit) || OrganizationUnit.top_organization_unit
    [self.children(parent)]
  end

  def self.children(parent)
    {
        text: parent.name,
        id: parent.id,
      nodes: parent.sub_organization_units.blank? ? nil : parent.sub_organization_units.collect{|x| self.children(x) }
      }
  end

  def sub_units
    sub_organization_units + sub_organization_units.collect{|x| x.sub_units}.flatten
  end

  def sub_users
    users + sub_organization_units.collect{|x| x.sub_users}.flatten
  end

  def sub_individuals
    Member.joins(:individual=>:person).where('people.organization_unit_id in (?)', sub_units.pluck(:id) << self.id).pluck('members.id')
  end

  def sub_students
    Member.joins(:student=>:person).where('people.organization_unit_id in (?)', sub_units.pluck(:id) << self.id).pluck('members.id')
  end

  def sub_institution_members
    Member.joins(:institution).where('institutions.organization_unit_id in (?)', sub_units.pluck(:id) << self.id).pluck('members.id')
  end

  def sub_members
    Member.where(id: sub_individuals + sub_students + sub_institution_members)
  end

  def paid_members(budget_year = BudgetYear.active)
    Member.where(id: sub_individuals + sub_students).joins(:payments).where('budget_year_id = ? and payments.status = ?', budget_year.try(:id), true)
  end

  def sub_payments(budget_year = BudgetYear.active)
    Payment.where('budget_year_id = ? and member_id in (?)', budget_year.try(:id), sub_members.pluck(:id))
  end

  def to_s
    name
  end
  
end
