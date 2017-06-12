$(document).ready(function() {

    $('#video-background').prop('volume', 0)
    let isPlaying = false
    let navFixed = false
    let list = $('#nav li').map(function() {
        return $.trim($(this).text())
    }).get()

    console.log(list)

    $('#video').click(function() {
        if (isPlaying) {
            $('#video-background').animate({volume: 0})
            $('.hide').fadeIn('slow')
            isPlaying = false
        } else {
            $('#video-background').animate({volume: 1})
            $('.hide').fadeOut('slow')
            isPlaying = true
        }
    })

    $(document).scroll(function() {
        let nav = $('#nav-container')
        if ($(document).scrollTop() > $('#video-background').height()) {
            console.log("passed nav")
            $('.content-section').css('padding-top', '50px')
            nav.css('position', 'fixed')
            navFixed = true
        } else {
            let currentList = $('#nav li').map(function() {
                return $.trim($(this).text())
            }).get()
            nav.css('position', 'relative')
            $('.content-section').css('padding-top', '0')
            $("#nav li:contains('Top')").html('<h3>' + list[currentList.indexOf('Top')] + '</h3>')
            navFixed = false
        }
    })
    
    $('#nav li').click(function() {
        if (this.id !== 'zario') {
            let element = $('.content-section#' + this.id)
            let heightToScroll = $(element).offset().top

            let currentList = $('#nav li').map(function() {
                return $.trim($(this).text())
            }).get()

            if ($(this).text() !== 'Top') {

                let navItem = this

                if (navFixed) {
                    $("html body").animate({scrollTop: heightToScroll - 20}, "slow", 'swing', function() {
                        $(navItem).html('<h3>Top</h3>')
                    })
                } else {
                    $("html body").animate({scrollTop: heightToScroll - 20}, "slow", 'swing', function() {
                        $(navItem).html('<h3>Top</h3>')
                    })
                }
                $("#nav li:contains('Top')").html('<h3>' + list[currentList.indexOf('Top')] + '</h3>')
                
            } else {
               
                $("html body").animate({scrollTop: 0}, "slow")
                $("#nav li:contains('Top')").html('<h3>' + list[currentList.indexOf('Top')] + '</h3>')  
            }
        }
    })

})

