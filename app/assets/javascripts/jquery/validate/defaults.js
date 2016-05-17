$.validator.setDefaults({
    highlight: function(element) {
        $(element).closest('.form-group').addClass('has-error');
    },
    unhighlight: function(element) {
        $(element).closest('.form-group').removeClass('has-error');
    },
    errorElement: 'span',
    errorClass: 'help-block',
    errorPlacement: function(error, element) {
        if (element.parent().find('.help-block').length === 0) {
            error.insertAfter(element);
        }
    },
    success: function (error) {
        error.remove();
    }
});
