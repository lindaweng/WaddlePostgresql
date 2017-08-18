// (function($) {
//     "use strict"; // Start of use strict

//     // Smooth scrolling using jQuery easing
//     $('a[href*="#"]:not([href="#"])').click(function() {
//         if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
//             var target = $(this.hash);
//             target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
//             if (target.length) {
//                 $('html, body').animate({
//                     scrollTop: (target.offset().top - 48)
//                 }, 1000, "easeInOutExpo");
//                 return false;
//             }
//         }
//     });

//     // Activate scrollspy to add active class to navbar items on scroll
//     $('body').scrollspy({
//         target: '#mainNav',
//         offset: 54
//     });

//     // Closes responsive menu when a link is clicked
//     $('.navbar-collapse>ul>li>a').click(function() {
//         $('.navbar-collapse').collapse('hide');
//     });

//     // Collapse the navbar when page is scrolled
//     $(window).scroll(function() {
//         if ($("#mainNav").offset().top > 100) {
//             $("#mainNav").addClass("navbar-shrink");
//         } else {
//             $("#mainNav").removeClass("navbar-shrink");
//         }
//     });

// })(jQuery); // End of use strict
$("#lm").click(function() {
    console.log("here")
    $('html, body').animate({
        scrollTop: $("#about").offset().top
    }, 2000);
});
$("#about_nav").click(function() {
    console.log("here")
    $('html, body').animate({
        scrollTop: $("#aboutDiv").offset().top
    }, 2000);
});
$("#form_nav").click(function() {
    console.log("here")
    $('html, body').animate({
        scrollTop: $("#form").offset().top
    }, 2000);
});
$("#contact_nav").click(function() {
    console.log("here")
    $('html, body').animate({
        scrollTop: $("#contact").offset().top
    }, 2000);
});
$("#sn").click(function() {
    console.log("here")
    $('html, body').animate({
        scrollTop: $("#form").offset().top
    }, 2000);
});
// 
