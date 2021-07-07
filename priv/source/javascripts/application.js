// eslint-disable-next-line
import '../images/**/*.+(gif|ico|jpg|png|svg)'
import 'lazysizes'
import 'lazysizes/plugins/parent-fit/ls.parent-fit'
import Swiper from 'swiper/bundle';
// import "./blotter.min.js";
// import "./channelSplitMaterial.js";
// import "./liquidDistortMaterial.js";
// import "./rollingDistortMaterial.js";
// import "./demo.js";


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
      initialSlide: 1,
      allowTouchMove: false
    },
    1300: {
      slidesPerView: 3,
      spaceBetween: 48,
      initialSlide: 1,
      allowTouchMove: false
    }
  }  
});

const swiper_manifesto = new Swiper('.swiper-manifesto', {
  pagination: {
    el: '.swiper-pagination--manifesto',
  },
  slidesPerView: 1,
  centeredSlides: true
});

// Move elements on scroll
var ball = document.querySelectorAll(".js-move-on-scroll");
function move(elements) {
  var movement = window.scrollY/5
  movement = movement + 1
  var i = 0
  for (i = 0; i < elements.length; i++) {  
    elements[i].style.transform = "translateY(-"+ movement +"px)"
  }
}
document.addEventListener('scroll', function(e) {
  move(ball);
});

isMotionReduced();
handleNavOverlayToggle();

