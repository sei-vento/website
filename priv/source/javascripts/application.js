// eslint-disable-next-line
import '../images/**/*.+(gif|ico|jpg|png|svg)'
import 'lazysizes'
import 'lazysizes/plugins/parent-fit/ls.parent-fit'
import Swiper from 'swiper/bundle';

// require('../images/favicons/site.webmanifest')
// require('../images/favicons/browserconfig.xml')

const isMotionReduced = () => {
  if ('matchMedia' in window && window.matchMedia('(prefers-reduced-motion)').matches) {
    return true;
  }
  return false;
}

const handleNavOverlayToggle = () => {
  const buttons = document.querySelectorAll('.js-nav-toggler')
  const menu = document.querySelector('.js-nav-menu')
  const hamburger = document.querySelector('.site-nav__menu')

  function expandButtons(expand = true) {
    buttons.forEach(button => {
      if (expand === true) {
        button.setAttribute('aria-expanded', 'true')
        button.classList.add('is-open')
        hamburger.classList.add('is-open')
      } else {
        button.setAttribute('aria-expanded', 'false')
        button.classList.remove('is-open')
        hamburger.classList.remove('is-open')
      }
    })
  }

  buttons.forEach(button => {
    button.addEventListener('click', () => {
      if (menu.getAttribute('aria-hidden') === 'true') {
        menu.setAttribute('aria-hidden', 'false')
        menu.classList.remove('is-hidden')
        expandButtons()
      } else {
        menu.setAttribute('aria-hidden', 'true')
        menu.classList.add('is-hidden')
        expandButtons(false)
      }
    })
  })
}

// const swiper = new Swiper('.swiper-container-custom', {
//   loop: true,
//   pagination: {
//     el: '.swiper-pagination-custom',
//   },
//   navigation: {
//     nextEl: '.swiper-button-next-custom',
//     prevEl: '.swiper-button-prev-custom',
//   },
//   slidesPerView: 1.4,
//   spaceBetween: 20,
//   centeredSlides: true,
//   breakpoints: {
//     768: {
//       slidesPerView: 2.5,
//       spaceBetween: 20
//     },
//     1024: {
//       slidesPerView: 3.6,
//       spaceBetween: 40
//     },
//     1920: {
//       slidesPerView: 4.5,
//       spaceBetween: 40
//     }
//   }  
// });

// // tab
// var links = document.querySelectorAll('.tab__item__link');
// var contents = document.querySelectorAll('.tab__content__item');
// var i = 0;
// for (i = 0; i < links.length; i++) {  
//   links[i].addEventListener('click', function (e) {
//     e.preventDefault();
//     var tab_id = this.getAttribute("href");    
//     for (i = 0; i < links.length; i++) {
//       links[i].classList.remove('is-active');
//     }
//     for (i = 0; i < contents.length; i++) {
//       contents[i].classList.remove('is-active');
//     }
//     this.classList.add('is-active');
//     var thisContent = document.querySelectorAll(tab_id)
//     for (i = 0; i < thisContent.length; i++) {
//       thisContent[i].classList.add('is-active');
//     }
//   })  
// }

// // Add class on click and remove on another click
// var specifiedElement = document.getElementById('open-dropdown');
// var thisContent = document.querySelectorAll('.tab__item__container');
// document.addEventListener('click', function(event) {
//   if (specifiedElement){
//     var isClickInside = specifiedElement.contains(event.target);
//     var i = 0;
//     if (isClickInside) {
//       for (i = 0; i < thisContent.length; i++) {
//         thisContent[i].classList.add('is-open');
//       }    
//     } else {
//       for (i = 0; i < thisContent.length; i++) {
//         thisContent[i].classList.remove('is-open');
//       }
//     }
//   }
// });

// // Animation scroll
// var getScroll = document.getElementById("get-scroll");
// var elements = document.querySelectorAll(".check-anim");
// var row = document.querySelectorAll(".service--list li")
// function checkAnim () {
//   var getScrollHeight = getScroll.offsetHeight;
//   for (i = 0; i < elements.length; i++) {    
//     if (elements[i].getBoundingClientRect().top < getScrollHeight) {
//       elements[i].classList.add("anim")
//     } else{
//       elements[i].classList.remove("anim")
//     }
//   }
//   for (i = 0; i < row.length; i++) {    
//     if (row[i].getBoundingClientRect().top < getScrollHeight) {
//       row[i].classList.add("anim")
//     } else{
//       row[i].classList.remove("anim")
//     }
//   }
// }
// checkAnim();
// document.addEventListener('scroll', function(e) {
//   checkAnim();
// });
// window.addEventListener('resize', function(e) {
//   checkAnim();
// });

// //on page load
// window.onload = function() {
//   setInterval(function(){
//     var body = document.body;
//     body.classList.add("body-loaded");
//   }, 1000);
// };

// //Animation with row different
// var stripe = document.querySelectorAll(".tiles__line");
// function move(elements) {
//   var movement = window.scrollY/10
//   for (i = 0; i < elements.length; i++) {  
//     var direction = i % 2 == 0 ? "-" : ""
//     elements[i].style.transform  = "translateX("+ direction + movement +"px)"
//   }
// }
// document.addEventListener('scroll', function(e) {
//   move(stripe);
// });

isMotionReduced();
handleNavOverlayToggle();

var controller = new ScrollMagic.Controller();
new ScrollMagic.Scene({
  duration: 100, // the scene should last for a scroll distance of 100px
  offset: 50 // start this scene after scrolling for 50px
})
  .setPin('#my-sticky-element') // pins the element for the the scene's duration
  .addTo(controller); // assign the scene to the controller