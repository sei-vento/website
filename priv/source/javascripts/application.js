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
  const toggler = document.querySelectorAll('.js-nav-toggler')
  const button_menu = document.querySelectorAll('.button--menu')
  const menu = document.querySelector('.js-nav-menu')
  const hamburger = document.querySelector('.canvas__header__top__right__hamburger')
  const button_apply = document.querySelector('.button--rounded')
  const button_menu_label = document.querySelector('.button--menu__label')


  function expandButtons(expand = true) {
    toggler.forEach(button => {
      if (expand === true) {
        button.setAttribute('aria-expanded', 'true')
        button.classList.add('is-open')
      } else {
        button.setAttribute('aria-expanded', 'false')
        button.classList.remove('is-open')
      }
    })
  }
  
  button_menu.forEach(button => {
    button.addEventListener('click', () => {
      if (menu.getAttribute('aria-hidden') === 'true') {
        menu.setAttribute('aria-hidden', 'false')
        menu.classList.remove('is-hidden')
        button_apply.classList.add('background-with-gradient')
        button_menu_label.innerHTML = "Close"
        hamburger.classList.add('is-open')
        expandButtons()
      } else {
        menu.setAttribute('aria-hidden', 'true')
        menu.classList.add('is-hidden')
        button_apply.classList.remove('background-with-gradient')
        button_menu_label.innerHTML = "Menu"
        hamburger.classList.remove('is-open')
        expandButtons(false)
      }
    })
  })
}

const swiper = new Swiper('.swiper-program', {
  pagination: {
    el: '.swiper-pagination--program',
  },
  slidesPerView: 1,
  centeredSlides: true,
  breakpoints: {
    1024: {
      slidesPerView: 3,
      spaceBetween: 24,
      initialSlide: 1
    },
    1300: {
      slidesPerView: 3,
      spaceBetween: 48,
      initialSlide: 1
    }
  }  
});

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

//Animation to start scroll
var svg_mask = document.querySelectorAll(".image-to-scroll .svg-mask");
var image = document.querySelectorAll(".image-to-scroll");

function move(elements) {
  var movement = window.scrollY/100
  movement = movement + 1
  var i = 0
  for (i = 0; i < elements.length; i++) {  
    elements[i].style.transform  = "scale("+ movement +")"
    console.log(window.scrollY)
    if (window.scrollY > 2000) {
      elements[i].style.display = "none"
    }
  }
}
function resize(elements) {
  var i = 0
  for (i = 0; i < elements.length; i++) {  
    if (window.scrollY > 2000) {
      elements[i].classList.add("resize")
    }
    if (window.scrollY > 2200) {
      window.scrollTo(0,0);
      elements[i].classList.add("hide")
    }
  }
}

document.addEventListener('scroll', function(e) {
  move(svg_mask);
  resize(image);
});

isMotionReduced();
handleNavOverlayToggle();

