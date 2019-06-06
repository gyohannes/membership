(function($){

    'use strict';
    $(function(){
        var $body=$('body');
        var $settingBox=$('.setting-box');
        $body.on('change','.setting-box .configuration-list-container ul li .switch input[type="checkbox"]',function(){
            var $this=$(this);
            var isChecked=$this.is(':checked');
            var $body=$('body');
            var dataClass=$this.data('class');var $boxedLayout=document.querySelector('.setting-box input[data-class="boxed-layout"]');if(dataClass==='footer-fixed'&&$boxedLayout.checked){$boxedLayout.checked=false;if(typeof Event==='function'||!document.fireEvent){var event=document.createEvent('HTMLEvents');event.initEvent('change',true,true);$boxedLayout.dispatchEvent(event);}else{$boxedLayout.fireEvent('onchange');}}
if(isChecked){$body.addClass(dataClass);}else{$body.removeClass(dataClass);}});$body.on('click','.setting-box .open-close-ear',function(){$(this).parent().toggleClass('open');});$body.on('click','.setting-box .theme-choose-list-container ul li',function(){var theme=$(this).data('theme');$('.setting-box .theme-choose-list-container ul li').removeClass('active');$(this).addClass('active');$body.removeClass(function(index,className){return(className.match(/(^|\s)theme-\S+/g)||[]).join(' ');});if(theme!==undefined&&theme!=='default'){$body.addClass('theme-'+theme);}});initSettingToolbox();function initSettingToolbox(){$body.append($settingBoxHtml);var $switchButtons=Array.prototype.slice.call(document.querySelectorAll('.setting-box .js-switch'));$switchButtons.forEach(function(e){var size=$(e).data('size');var options={};options['color']='#009688';if(size!==undefined)options['size']=size;var switchery=new Switchery(e,options);});}});}(jQuery));