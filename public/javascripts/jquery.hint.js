// EZPZ Hint v1.1.1; Copyright (c) 2009 Mike Enriquez, http://theezpzway.com; Released under the MIT License
(function(a){a.fn.ezpz_hint=function(e){var f={hintClass:'ezpz-hint',hintName:'ezpz_hint_dummy_input'};var c=a.extend(f,e);return this.each(function(){var b;var d;text=a(this).attr('title');a('<input type="text" name="temp" value="" />').insertBefore(a(this));b=a(this).prev('input:first');b.attr('class',a(this).attr('class'));b.attr('size',a(this).attr('size'));b.attr('name',c.hintName);b.attr('autocomplete','off');b.attr('tabIndex',a(this).attr('tabIndex'));b.addClass(c.hintClass);b.val(text);a(this).hide();a(this).attr('autocomplete','off');b.focus(function(){d=a(this);a(this).next('input:first').show();a(this).next('input:first').focus();a(this).next('input:first').unbind('blur').blur(function(){if(a(this).val()==''){a(this).hide();d.show()}});a(this).hide()});if(a(this).val()!=''){b.focus()};a('form').submit(function(){a('.'+c.hintName).remove()})})}})(jQuery);