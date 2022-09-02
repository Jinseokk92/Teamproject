$(function() {
	'use strict';

  $('.form-control').on('input', function() {
	  let $field = $(this).closest('.form-group');
	  if (this.value) {
	    $field.addClass('field--not-empty');
	  } else {
	    $field.removeClass('field--not-empty');
	  }
	});

});