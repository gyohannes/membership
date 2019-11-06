class BoardMembersTermsController < ApplicationController
  before_action :set_board_members_term, only: [:show, :edit, :update, :destroy]

  # GET /board_members_terms
  # GET /board_members_terms.json
  def index
    @board_members_terms = BoardMembersTerm.all
  end

  # GET /board_members_terms/1
  # GET /board_members_terms/1.json
  def show
  end

  # GET /board_members_terms/new
  def new
    @board_members_term = BoardMembersTerm.new
  end

  # GET /board_members_terms/1/edit
  def edit
  end

  # POST /board_members_terms
  # POST /board_members_terms.json
  def create
    @board_members_term = BoardMembersTerm.new(board_members_term_params)

    respond_to do |format|
      if @board_members_term.save
        format.html { redirect_to AssociationDetail.first, notice: 'Board members term was successfully created.' }
        format.json { render :show, status: :created, location: @board_members_term }
      else
        format.html { render :new }
        format.json { render json: @board_members_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /board_members_terms/1
  # PATCH/PUT /board_members_terms/1.json
  def update
    respond_to do |format|
      if @board_members_term.update(board_members_term_params)
        format.html { redirect_to AssociationDetail.first, notice: 'Board members term was successfully updated.' }
        format.json { render :show, status: :ok, location: @board_members_term }
      else
        format.html { render :edit }
        format.json { render json: @board_members_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /board_members_terms/1
  # DELETE /board_members_terms/1.json
  def destroy
    @board_members_term.destroy
    respond_to do |format|
      format.html { redirect_to board_members_terms_url, notice: 'Board members term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board_members_term
      @board_members_term = BoardMembersTerm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_members_term_params
      params.require(:board_members_term).permit(:name, :from, :to, :status, board_members_attributes: [:id, :person_id, :role, :_destroy])
    end
end
