(function( $ ){
    $.fn.loadMarkdown = function(options) {
            
        var settings = jQuery.extend({
            preAdd: function(content){ return content },
            postAdd: function(element){  },
            replaceWith: false 
        }, options);
        
        var currentElement = this;
    
        var successFunction = function(data) {
                        
    		var converter = new Markdown.Converter();
			converter.hooks.chain("postConversion", function (text) {
				return settings.preAdd(text);
			});
			
			//alert(data.val();
			
			var result = converter.makeHtml(data); 
            
			
            if (settings.replaceWith) {
                currentElement.replaceWith(result);    
            } else {
                currentElement.append(result);
            }

            settings.postAdd();
        };
    
        $.ajax({
            url: options.url,
            success: successFunction,
			dataType: 'html'
        });
    };
    
    
    
    $(document).ready(function () {
        $('[data-markdown-url]').each(function(index) {
            var item = $(this);
            var options = {url: item.attr('data-markdown-url')};
            
            if (item.attr('data-markdown-replaceWith') !== undefined)
                options.replaceWith = (item.attr('data-markdown-replaceWith') == 'true');
                
            if (item.attr('data-markdown-preAdd') !== undefined) 
                eval('options.preAdd = ' + item.attr('data-markdown-preAdd'));
                
            if (item.attr('data-markdown-postAdd') !== undefined)
                eval('options.postAdd = ' + item.attr('data-markdown-postAdd'));
            
                            
            item.loadMarkdown(options);
        });
    });
    
})( jQuery );