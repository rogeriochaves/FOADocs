//= require ckeditor-jquery

var simpleFormatRE1 = /\r\n?/g;
var simpleFormatRE2 = /\n\n+/g;
var simpleFormatRE3 = /([^\n]\n)(?=[^\n])/g;
function simpleFormat(str) {
    var fstr = str;
    fstr = fstr.replace(simpleFormatRE1, "\n") // \r\n and \r -> \n
    fstr = fstr.replace(simpleFormatRE2, "</p>\n\n<p>") // 2+ newline  -> paragraph
    fstr = fstr.replace(simpleFormatRE3, "$1<br/>") // 1 newline   -> br
    //fstr = "<p>" + fstr + "</p>";
    return fstr;
}
function simpleUnformat(str) {
    var fstr = str;
    fstr = fstr.replace(/<p><\/p>/g, "");
    fstr = fstr.replace(/<p>/g, "\n");
    fstr = fstr.replace(/<\/p>/g, "\n");
    fstr = fstr.replace(/<br \/>/g, "\n");
    fstr = fstr.replace(/<br>/g, "\n");
    fstr = fstr.replace(/<br\/>/g, "\n");
    return fstr;
}

$(document).ready(function(){
	$('body').delegate('[data-editable]', 'click', function(){
		var $this = $(this)
          , val = $this.html()
          , key = $this.data('editable');

		if ($this.find('textarea').length > 0) return false;
        elem = $('<textarea>').html(val).attr({id: key});
        $this.html(elem);
        CKEDITOR.replace(key, { "language": 'pt-BR',"toolbar": 'Basic',"width": $this.width(), "height": $this.height() + 30 });
        CKEDITOR.instances[key].on('blur', function(e){
            var val = CKEDITOR.instances[key].getData();
            CKEDITOR.instances[key].destroy();
            $this.html(val);
            $.ajax({
				type: "PUT",
				url: '/editables/'+key+'.json',
				data: JSON.stringify({_method:'PUT', text: val}),
				contentType: 'application/json', // format of request payload
				dataType: 'json', // format of the response
				success: function() {
					// okay
				}
			});
        });
	});
});