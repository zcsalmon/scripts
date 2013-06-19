(function()
{
    var msie  = /MSIE /.test( navigator.userAgent );
    var msie7 = /MSIE 7/.test( navigator.userAgent );

    function getStyle(e,prop,raw)
    {
        var result;
        if( document.defaultView &&
            document.defaultView.getComputedStyle )
        {
            result = document.defaultView.getComputedStyle(e,null).getPropertyValue( prop );
        }
        else
        if( e.currentStyle )
        {
            result = e.currentStyle[ prop ];
        }
        else
        {
            return 0;
        }

        if( raw &&
            result )
        {
            result = parseInt( result.split( 'px' )[ 0 ] );
        }

        return result;
    }

    function available(e,hOrW)
    {
        var result = 0;
        var node   = e.parentNode;
        var root   = node == (document.body||document.documentElement);
        var last   = null;
        var client = hOrW ? 'clientHeight' : 'clientWidth';
        var offset = hOrW ? 'offsetHeight' : 'offsetWidth';
        var skew   = root ? ( ( hOrW ? e.offsetTop : e.offsetLeft ) || 0 ) + ( msie ? 16 : 0 ) : 0;
        var extra1 = hOrW ? 'top' : 'left';
        var extra2 = hOrW ? 'bottom' : 'right';

        var fallback = function()
        {
            var fb;
            var node;

            if( document.body )
            {
                node = document.body;
                fb   = node[ client ];
            }
            else
            if( document.documentElement &&
                document.documentElement[ client ] )
            {
                node = document.documentElement;
                fb   = node[ client ];
            }

            // Cases where IE or browsers report differing heights for client.
            // So we'll use the higher value of the two
            // ---------------------------------------------------------------
            if( document.body &&
                document.documentElement &&
                document.documentElement[ client ] )
            {
                var db  = document.body;
                var de  = document.documentElement;
                var dbc = db[ client ];
                var dec = de[ client ];

                if( dbc < dec )
                {
                    fb   = dec;
                    node = de;
                }
                else
                {
                    fb   = dbc;
                    node = db;
                }
            }

            if( node )
            {
                var margin1 = getStyle( node, 'margin-'+extra1, true ) || 0;
                var margin2 = getStyle( node, 'margin-'+extra2, true ) || 0;

                fb -= margin2 + skew + ( ( e.offsetTop || margin1 ) - margin1 );
            }
            return fb;
        }

        while( true )
        {
            if( !node )
            {
                result = fallback();
                break;
            }

            // Otherwise see if the current node has a set height, but only if it's explicitly coming from CSS.
            // ------------------------------------------------------------------------------------------------
            if( node[ offset ] &&
                getStyle( node, hOrW ? 'height' : 'width', false ) )
            {
                result = node[ root ? client : offset ];

                // Correct for the actual height of the siblings of the last ancestor.
                // -------------------------------------------------------------------
                if( last )
                {
                    var cl = node.childNodes.length;
                    for( var i = 0 ; i < cl ; ++i )
                    {
                        var child = node.childNodes[ i ];
                        if( child !== last &&
                            child[ offset ] )
                        {
                            result -= child[ offset ];
                        }
                    }
                }

                if( ( hOrW ? 220 : 400 ) > result )
                {
                    result = fallback();
                }
                else
                {
                    var pad1    = getStyle( e, 'padding-'+extra1, true ) || 0;
                    var pad2    = getStyle( e, 'padding-'+extra2, true ) || 0;
                    var border1 = getStyle( e, 'border-'+extra1+'-width', true ) || 0;
                    var border2 = getStyle( e, 'border-'+extra2+'-width', true ) || 0;
                    var margin  = getStyle( e.parentNode, 'margin-'+extra2, true ) || 0;

                    result -= pad1 + pad2 + border1 + border2 + skew + margin;
                }

                break;
            }

            // Iterate up the tree.
            // --------------------
            last = node;
            node = node.parentNode;
        }

        return result;
    }

    var postano             = document.getElementById('postano');
    var iframe              = document.createElement( 'iframe' );
    var userDefWidth        = '';
    var userDefHeight       = '';
    var userDefScroll       = '';
    var userDefBorder       = '';

    var userDefResizeWidth  = '';
    var userDefResizeHeight = '';
    var setHeight           = true;
    var footer              = 0;
    if( isNaN( footer ) )
    {
        footer = 0;
    }

    // defaults
    var height              =  1024;
    var width               =  768;
    var heightScale         = 1;
    var widthScale          = 1;
    var scrolling           = "yes";
    var frameBorder         = 0;
    var resizeWidth         = true;
    var resizeHeight        = true;

    if( userDefResizeWidth.length > 0 &&
        userDefResizeWidth === "false" )
    {
        resizeWidth = false;
    }

    if( userDefResizeHeight.length > 0 &&
        userDefResizeHeight === "false" )
    {
        resizeHeight = false;
    }

    var fixedHeight         = false;
    var fixedWidth          = false;
    
    function stringEndsWith(string, suffix)
    {
        return string.match(suffix + "$" ) == suffix;
    }

    // settings priorties are: userdefined -> environmental -> defaults
    // ----------------------------------------------------
    if( userDefWidth.length > 0 )
    {
        if( userDefWidth.charAt( userDefWidth.length - 1 ) == '%' )
        {
            widthScale = parseInt( userDefWidth.substring( 0, userDefWidth.length - 1 ) ) / 100;
            width      = available( postano, false );

        }
        else
        if( stringEndsWith( userDefWidth, 'px' ) ) 
        {
            width = userDefWidth.substring( pxLoc, 0 );
        }
        else
        {
            width      = userDefWidth;
        }

        fixedWidth = true;
    }
    else
    {
        width = available( postano, false );
    }

    if( userDefHeight.length > 0 )
    {
        if( userDefHeight.charAt( userDefHeight.length - 1 ) == '%' )
        {
            heightScale = parseInt( userDefHeight.substring( 0, userDefHeight.length - 1 ) ) / 100;
            height      = available( postano, true );
        }
        else
        if( stringEndsWith( userDefHeight, 'px' ) )
        {
            userDefHeight = userDefHeight.substring( pxLoc, 0 );
        }
        else
        {
            height      = userDefHeight;
        }

        fixedHeight = true;
    }
    else
    {
        height = available( postano, true );
    }

    if( userDefScroll.length > 0 )
    {
        scrolling = userDefScroll;
    }

    if( userDefBorder.length > 0 )
    {
        frameBorder = userDefBorder;
    }

    width                   *= widthScale;
    height                  *= heightScale;
    height                  -= footer;

    iframe.id                = 'postanoFrame';
    iframe.name              = 'postanoFrame';
    iframe.width             = width;
    iframe.height            = height;
    iframe.frameBorder       = frameBorder;
    iframe.scrolling         = "auto";
    iframe.src               = document.location.protocol + '//www.postano.com/?pid=66590&scrolling=' + scrolling + '&height=' + height + '&width=' + width +'&ovf=&type=embed&click=&mini=&source=' + encodeURIComponent(document.location.href);
 
    iframe.allowTransparency = true;

    postano.appendChild( iframe );

    postano.style.height     = height;
    postano.style.width      = width;

    window.onresize = function()
    {
        if( navigator &&
            navigator.userAgent &&
            msie7 )
        {
            // Mitigate old IE browsers from going into an infinite loop. the ie resize bug.
            // -----------------------------------------------------------------------------
        }
        else
        {
            try
            {
                var postanoFrame = document.getElementById( 'postanoFrame' );
                var postano      = document.getElementById( 'postano' );

                if( resizeHeight &&
                    !fixedHeight )
                {
                    var height = Math.floor( available( postano, true ) * heightScale ) - footer;

                    postanoFrame.height  = height;
                    postano.style.height = height;
                }

                if( resizeWidth &&
                    !fixedWidth )
                {
                    var width = Math.floor( available( postano, false ) * widthScale );

                    postanoFrame.width  = width;
                    postano.style.width = width;
                }
            }
            catch( e )
            {

            }
        }
    };
    
    // Event listener for turning off the scrollbar on embeds
    // ------------------------------------------------------
    var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
    var eventer = window[eventMethod];
    var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";
       
    // Listen to message from child window
    eventer(messageEvent,function( event )
    {
        switch( event.data )
        {
            case 'noscroll':
            case 'scroll':
                scroll( event );
                break;
            default:
                break;
        }
    },false);
    
    var scroll = function( event )
    {
                var postanoFrame = window.top.document.getElementsByName('postanoFrame')[0];
        switch( event.data )
        {
            case 'noscroll':
                postanoFrame.setAttribute('scrolling', 'no');
                break;
            case 'scroll':
                postanoFrame.setAttribute('scrolling', 'yes');
                break;
            default:
                break;
        }
    }

    window.postano =
    {
        refresh : function(id)
        {
            document.getElementById((id||'postano')+'Frame').contentWindow.postMessage('refresh', 'http://www.postano.com');
        }
    };
    
    var eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
var eventer = window[eventMethod];
var messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";

// Listen to message from child window
eventer(messageEvent,function( event )
{
    switch( event.data )
    {
        case 'scrollToTop':
            var frame  = window.document.getElementsByName('postanoFrame')[0];
            var offset = frame.offsetTop;
            
            if( window.pageYOffset > offset )
            {
                window.scrollTo(0, offset);
            }
            break;
        case 'position':
            window.scrollTo(0, g_yposition );
            break;
        case 'getYPosition':
            g_yposition = window.pageYOffset;
            break;
        default:
        	// do nothing
        	break;
    }
},false);