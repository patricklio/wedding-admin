import { Sine, TweenMax, TimelineMax } from "gsap";
import 'select2'

let public_vars = public_vars || {};

(function ($, window, undefined) {
  "use strict";

  $(document).ready(function (){
    // Sidebar Menu var
    public_vars.$body = $("body");
    public_vars.$pageContainer = public_vars.$body.find(".page-container");
    // public_vars.$chat = public_vars.$pageContainer.find('#chat');
    public_vars.$horizontalMenu = public_vars.$pageContainer.find('header.navbar');
    public_vars.$sidebarMenu = public_vars.$pageContainer.find('.sidebar-menu');
    public_vars.$mainMenu = public_vars.$sidebarMenu.find('#main-menu');
    public_vars.$mainContent = public_vars.$pageContainer.find('.main-content');
    public_vars.$sidebarUserEnv = public_vars.$sidebarMenu.find('.sidebar-user-info');
    public_vars.$sidebarUser = public_vars.$sidebarUserEnv.find('.user-link');

    public_vars.$body.addClass('loaded');

    // Just to make sure...
    $(window).on('error', function (ev) {
      // Do not let page without showing if JS fails somewhere
      init_page_transitions();
    });

    if (public_vars.$pageContainer.hasClass('right-sidebar')) {
      public_vars.isRightSidebar = true;
    }


    // Sidebar Menu Setup
    setup_sidebar_menu();



    // Horizontal Menu Setup
    setup_horizontal_menu();



    // Sidebar Collapse icon
    public_vars.$sidebarMenu.find(".sidebar-collapse-icon").on('click', function (ev) {
      ev.preventDefault();

      const with_animation = $(this).hasClass('with-animation');

      toggle_sidebar_menu(with_animation);
    });




    // Mobile Sidebar Collapse icon
    public_vars.$sidebarMenu.find(".sidebar-mobile-menu a").on('click', function (ev) {
      ev.preventDefault();

      const with_animation = $(this).hasClass('with-animation');

      if (with_animation) {
        public_vars.$mainMenu.stop().slideToggle('normal', function () {
          public_vars.$mainMenu.css('height', 'auto');
        });
      }
      else {
        public_vars.$mainMenu.toggle();
      }
    });



    // Mobile Horizontal Menu Collapse icon
    public_vars.$horizontalMenu.find(".horizontal-mobile-menu a").on('click', function (ev) {
      ev.preventDefault();

      const $menu = public_vars.$horizontalMenu.find('.navbar-nav'),
        with_animation = $(this).hasClass('with-animation');

      if (with_animation) {
        $menu.stop().slideToggle('normal', function () {
          $menu.attr('height', 'auto');

          if ($menu.css('display') == 'none') {
            $menu.attr('style', '');
          }
        });
      }
      else {
        $menu.toggle();
      }
    });




    // Close Sidebar if Tablet Screen is visible
    public_vars.$sidebarMenu.data('initial-state', (public_vars.$pageContainer.hasClass('sidebar-collapsed') ? 'closed' : 'open'));

    if (is('tabletscreen')) {
      hide_sidebar_menu(false);
    }




    // NiceScroll
    if ($.isFunction($.fn.niceScroll)) {
      const nicescroll_defaults = {
        cursorcolor: '#d4d4d4',
        cursorborder: '1px solid #ccc',
        railpadding: { right: 3 },
        cursorborderradius: 1,
        autohidemode: true,
        sensitiverail: true
      };

      public_vars.$body.find('.dropdown .scroller').niceScroll(nicescroll_defaults);

      $(".dropdown").on("shown.bs.dropdown", function () {
        $(".scroller").getNiceScroll().resize();
        $(".scroller").getNiceScroll().show();
      });

      const fixed_sidebar = $(".sidebar-menu.fixed");

      if (fixed_sidebar.length == 1) {
        const fs_tm = 0;

        fixed_sidebar.niceScroll({
          cursorcolor: '#454a54',
          cursorborder: '1px solid #454a54',
          railpadding: { right: 3 },
          railalign: 'right',
          cursorborderradius: 1
        });

        fixed_sidebar.on('click', 'li a', function () {
          fixed_sidebar.getNiceScroll().resize();
          fixed_sidebar.getNiceScroll().show();

          window.clearTimeout(fs_tm);

          fs_tm = setTimeout(function () {
            fixed_sidebar.getNiceScroll().resize();
          }, 500);
        });
      }
    }



    // Scrollable
    if ($.isFunction($.fn.slimScroll)) {
      $(".scrollable").each(function (i, el) {
        const $this = $(el),
          height = attrDefault($this, 'height', $this.height());

        if ($this.is(':visible')) {
          $this.removeClass('scrollable');

          if ($this.height() < parseInt(height, 10)) {
            height = $this.outerHeight(true) + 10;
          }

          $this.addClass('scrollable');
        }

        $this.css({ maxHeight: '' }).slimScroll({
          height: height,
          position: attrDefault($this, 'scroll-position', 'right'),
          color: attrDefault($this, 'rail-color', '#000'),
          size: attrDefault($this, 'rail-width', 6),
          borderRadius: attrDefault($this, 'rail-radius', 3),
          opacity: attrDefault($this, 'rail-opacity', .3),
          alwaysVisible: parseInt(attrDefault($this, 'autohide', 1), 10) == 1 ? false : true
        });
      });
    }




    // Popovers and tooltips
    $('[data-toggle="popover"]').each(function (i, el) {
      const $this = $(el),
        placement = attrDefault($this, 'placement', 'right'),
        trigger = attrDefault($this, 'trigger', 'click'),
        popover_class = $this.hasClass('popover-secondary') ? 'popover-secondary' : ($this.hasClass('popover-primary') ? 'popover-primary' : ($this.hasClass('popover-default') ? 'popover-default' : ''));

      $this.popover({
        placement: placement,
        trigger: trigger
      });

      $this.on('shown.bs.popover', function (ev) {
        const $popover = $this.next();

        $popover.addClass(popover_class);
      });
    });

    $('[data-toggle="tooltip"]').each(function (i, el) {
      const $this = $(el),
        placement = attrDefault($this, 'placement', 'top'),
        trigger = attrDefault($this, 'trigger', 'hover'),
        popover_class = $this.hasClass('tooltip-secondary') ? 'tooltip-secondary' : ($this.hasClass('tooltip-primary') ? 'tooltip-primary' : ($this.hasClass('tooltip-default') ? 'tooltip-default' : ''));

      $this.tooltip({
        placement: placement,
        trigger: trigger
      });

      $this.on('shown.bs.tooltip', function (ev) {
        const $tooltip = $this.next();

        $tooltip.addClass(popover_class);
      });
    });



    // Modal Static
    public_vars.$body.on('click', '.modal[data-backdrop="static"]', function (ev) {
      if ($(ev.target).is('.modal')) {
        var $modal_dialog = $(this).find('.modal-dialog .modal-content'),
          tt = new TimelineMax({ paused: true });

        tt.append(TweenMax.to($modal_dialog, .1, { css: { scale: 1.1 }, ease: Expo.easeInOut }));
        tt.append(TweenMax.to($modal_dialog, .3, { css: { scale: 1 }, ease: Back.easeOut }));

        tt.play();
      }
    });




    // Fit main content height
    fit_main_content_height();

    let fmch = 0;
    const fmch_fn = function () {

      window.clearTimeout(fmch);
      fit_main_content_height();

      fmch = setTimeout(fmch_fn, 800);
    };

    fmch_fn();

    // Apply Page Transition
    onPageAppear(init_page_transitions);

  });


  // Enable/Disable Resizable Event
  var wid = 0;

  $(window).resize(function () {
    clearTimeout(wid);
    wid = setTimeout(trigger_resizable, 200);
  });

  //Init plugins
  initSelect2Plugin();


})(jQuery, window);



/* Functions */
function fit_main_content_height() {
  let $ = jQuery;

  if (public_vars.$sidebarMenu.length && public_vars.$sidebarMenu.hasClass('fixed') == false) {
    public_vars.$sidebarMenu.css('min-height', '');
    public_vars.$mainContent.css('min-height', '');

    // if (isxs()) {
    //   if (typeof reset_mail_container_height != 'undefined')
    //     reset_mail_container_height();
    //   return;

    //   if (typeof fit_calendar_container_height != 'undefined')
    //     reset_calendar_container_height();
    //   return;
    // }

    let sm_height = public_vars.$sidebarMenu.outerHeight(),
      mc_height = public_vars.$mainContent.outerHeight(),
      doc_height = $(document).height(),
      win_height = $(window).height(),
      sm_height_real = 0;

    if (win_height > doc_height) {
      doc_height = win_height;
    }

    if (public_vars.$horizontalMenu.length > 0) {
      var hm_height = public_vars.$horizontalMenu.outerHeight();

      doc_height -= hm_height;
      sm_height -= hm_height;
    }

    public_vars.$mainContent.css('min-height', doc_height);
    public_vars.$sidebarMenu.css('min-height', doc_height);
    // public_vars.$chat.css('min-height', doc_height);

    // if (typeof fit_mail_container_height != 'undefined')
    //   fit_mail_container_height();

    // if (typeof fit_calendar_container_height != 'undefined')
    //   fit_calendar_container_height();
  }
}

// Sidebar Menu Setup
function setup_sidebar_menu() {
  let $items_with_submenu = public_vars.$sidebarMenu.find('li:has(ul)'),
    submenu_options = {
      submenu_open_delay: 0.5,
      submenu_open_easing: Sine.easeInOut,
      submenu_opened_class: 'opened'
    },
    root_level_class = 'root-level',
    is_multiopen = public_vars.$mainMenu.hasClass('multiple-expanded');

  public_vars.$mainMenu.find('> li').addClass(root_level_class);

  // Add active for menu that has sub menu
  var url = window.location.href;
  // for sidebar menu entirely but not cover treeview
  const selected = public_vars.$mainMenu.find('.' + root_level_class+ '> a').filter(function() {
      return this.href == url;
  });
  if (selected) {
      selected.parent().addClass('active');
      selected.parents('li').addClass('active')
  }

  $items_with_submenu.each(function (i, el) {
    let $this = $(el),
      $link = $this.find('> a'),
      $submenu = $this.find('> ul');

    $this.addClass('has-sub');

    $link.click(function (ev) {
      ev.preventDefault();

      if (!is_multiopen && $this.hasClass(root_level_class)) {
        let close_submenus = public_vars.$mainMenu.find('.' + root_level_class).not($this).find('> ul');

        close_submenus.each(function (i, el) {
          let $sub = $(el);
          menu_do_collapse($sub, $sub.parent(), submenu_options);
        });
      }

      if (!$this.hasClass(submenu_options.submenu_opened_class)) {
        // const current_height;

        if (!$submenu.is(':visible')) {
          menu_do_expand($submenu, $this, submenu_options);
        }
      }
      else {
        menu_do_collapse($submenu, $this, submenu_options);
      }

      fit_main_content_height();
    });

  });

  // Open the submenus with "opened" class
  public_vars.$mainMenu.find('.' + submenu_options.submenu_opened_class + ' > ul').addClass('visible');

  // Well, somebody may forgot to add "active" for all inhertiance, but we are going to help you (just in case)
  // - we do this job for you for free :P!
  if (public_vars.$mainMenu.hasClass('auto-inherit-active-class')) {
    menu_set_active_class_to_parents(public_vars.$mainMenu.find('.active'));
  }

  // Search Input
  // const $search_input = public_vars.$mainMenu.find('#search input[type="text"]'),
  //   $search_el = public_vars.$mainMenu.find('#search');

  // public_vars.$mainMenu.find('#search form').submit(function (ev) {
  //   var is_collapsed = public_vars.$pageContainer.hasClass('sidebar-collapsed');

  //   if (is_collapsed) {
  //     if ($search_el.hasClass('focused') == false) {
  //       ev.preventDefault();
  //       $search_el.addClass('focused');

  //       $search_input.focus();

  //       return false;
  //     }
  //   }
  // });

  // $search_input.on('blur', function (ev) {
  //   var is_collapsed = public_vars.$pageContainer.hasClass('sidebar-collapsed');

  //   if (is_collapsed) {
  //     $search_el.removeClass('focused');
  //   }
  // });


  // Collapse Icon (mobile device visible)
  var show_hide_menu = $('');

  public_vars.$sidebarMenu.find('.logo-env').append(show_hide_menu);
}

function menu_do_expand($submenu, $this, options) {
  $submenu.addClass('visible').height('');
  current_height = $submenu.outerHeight();

  const props_from = {
    opacity: .2,
    height: 0,
    top: -20
  },
    props_to = {
      height: current_height,
      opacity: 1,
      top: 0
    };

  if (isxs()) {
    delete props_from['opacity'];
    delete props_from['top'];

    delete props_to['opacity'];
    delete props_to['top'];
  }

  TweenMax.set($submenu, { css: props_from });

  $this.addClass(options.submenu_opened_class);

  TweenMax.to($submenu, options.submenu_open_delay, {
    css: props_to, ease: options.submenu_open_easing, onComplete: function () {
      $submenu.attr('style', '');
      fit_main_content_height();
    }
  });
}


function menu_do_collapse($submenu, $this, options) {
  if (public_vars.$pageContainer.hasClass('sidebar-collapsed') && $this.hasClass('root-level')) {
    return;
  }

  $this.removeClass(options.submenu_opened_class);

  TweenMax.to($submenu, options.submenu_open_delay, {
    css: { height: 0, opacity: .2 }, ease: options.submenu_open_easing, onComplete: function () {
      $submenu.removeClass('visible');
      fit_main_content_height();
    }
  });
}


function menu_set_active_class_to_parents($active_element) {
  if ($active_element.length) {
    var $parent = $active_element.parent().parent();

    $parent.addClass('active');

    if (!$parent.hasClass('root-level'))
      menu_set_active_class_to_parents($parent)
  }
}


// Horizontal Menu Setup
function setup_horizontal_menu() {
  var $ = jQuery,
    $nav_bar_menu = public_vars.$horizontalMenu.find('.navbar-nav'),
    $items_with_submenu = $nav_bar_menu.find('li:has(ul)'),
    $search = public_vars.$horizontalMenu.find('li#search'),
    $search_input = $search.find('.search-input'),
    $search_submit = $search.find('form'),
    root_level_class = 'root-level',
    is_multiopen = $nav_bar_menu.hasClass('multiple-expanded'),
    submenu_options = {
      submenu_open_delay: 0.5,
      submenu_open_easing: Sine.easeInOut,
      submenu_opened_class: 'opened'
    };

  $nav_bar_menu.find('> li').addClass(root_level_class);

  $items_with_submenu.each(function (i, el) {
    var $this = $(el),
      $link = $this.find('> a'),
      $submenu = $this.find('> ul');

    $this.addClass('has-sub');

    setup_horizontal_menu_hover($this, $submenu);

    // xs devices only
    $link.click(function (ev) {
      if (isxs()) {
        ev.preventDefault();

        if (!is_multiopen && $this.hasClass(root_level_class)) {
          var close_submenus = $nav_bar_menu.find('.' + root_level_class).not($this).find('> ul');

          close_submenus.each(function (i, el) {
            var $sub = $(el);
            menu_do_collapse($sub, $sub.parent(), submenu_options);
          });
        }

        if (!$this.hasClass(submenu_options.submenu_opened_class)) {
          var current_height;

          if (!$submenu.is(':visible')) {
            menu_do_expand($submenu, $this, submenu_options);
          }
        }
        else {
          menu_do_collapse($submenu, $this, submenu_options);
        }

        fit_main_content_height();
      }
    });

  });


  // Search Input
  // if ($search.hasClass('search-input-collapsed')) {
  //   $search_submit.submit(function (ev) {
  //     if ($search.hasClass('search-input-collapsed')) {
  //       ev.preventDefault();
  //       $search.removeClass('search-input-collapsed');
  //       $search_input.focus();

  //       return false;
  //     }
  //   });

  //   $search_input.on('blur', function (ev) {
  //     $search.addClass('search-input-collapsed');
  //   });
  // }
}

jQuery(public_vars, {
  hover_index: 4
});

function setup_horizontal_menu_hover($item, $sub) {
  const del = 0.5,
    trans_x = -10,
    ease = Quad.easeInOut;

  TweenMax.set($sub, { css: { autoAlpha: 0, transform: "translateX(" + trans_x + "px)" } });

  $item.hoverIntent({
    over: function () {
      if (isxs())
        return false;

      if ($sub.css('display') == 'none') {
        $sub.css({ display: 'block', visibility: 'hidden' });
      }

      $sub.css({ zIndex: ++public_vars.hover_index });
      TweenMax.to($sub, del, { css: { autoAlpha: 1, transform: "translateX(0px)" }, ease: ease });
    },

    out: function () {
      if (isxs())
        return false;

      TweenMax.to($sub, del, {
        css: { autoAlpha: 0, transform: "translateX(" + trans_x + "px)" }, ease: ease, onComplete: function () {
          TweenMax.set($sub, { css: { transform: "translateX(" + trans_x + "px)" } });
          $sub.css({ display: 'none' });
        }
      });
    },

    timeout: 300,
    interval: 50
  });

}

// Page Transitions
function init_page_transitions() {
  fit_main_content_height();

  let transitions = ['page-fade', 'page-left-in', 'page-right-in', 'page-fade-only'];

  for (let i in transitions) {
    let transition_name = transitions[i];

    if (public_vars.$body.hasClass(transition_name)) {
      public_vars.$body.addClass(transition_name + '-init')

      setTimeout(function () {
        public_vars.$body.removeClass(transition_name + ' ' + transition_name + '-init');

      }, 850);

      return;
    }
  }
}

// Page Visibility API
function onPageAppear(callback) {

  var hidden, state, visibilityChange;

  if (typeof document.hidden !== "undefined") {
    hidden = "hidden";
    visibilityChange = "visibilitychange";
    state = "visibilityState";
  }
  else if (typeof document.mozHidden !== "undefined") {
    hidden = "mozHidden";
    visibilityChange = "mozvisibilitychange";
    state = "mozVisibilityState";
  }
  else if (typeof document.msHidden !== "undefined") {
    hidden = "msHidden";
    visibilityChange = "msvisibilitychange";
    state = "msVisibilityState";
  }
  else if (typeof document.webkitHidden !== "undefined") {
    hidden = "webkitHidden";
    visibilityChange = "webkitvisibilitychange";
    state = "webkitVisibilityState";
  }

  if (document[state] || typeof document[state] == 'undefined') {
    callback();
  }

  document.addEventListener(visibilityChange, callback, false);
}







// ! Sidebar Menu Options
jQuery.extend(public_vars, {
  sidebarCollapseClass: 'sidebar-collapsed',
  sidebarOnTransitionClass: 'sidebar-is-busy',
  sidebarOnHideTransitionClass: 'sidebar-is-collapsing',
  sidebarOnShowTransitionClass: 'sidebar-is-showing',
  sidebarTransitionTime: 600, // ms
  isRightSidebar: false
});

function show_sidebar_menu(with_animation) {
  if (isxs())
    return;

  // if (public_vars.isRightSidebar) {
  //   rb_show_sidebar_menu(with_animation);
  //   return;
  // }

  if (!with_animation) {
    public_vars.$pageContainer.removeClass(public_vars.sidebarCollapseClass);
  }
  else {
    if (public_vars.$mainMenu.data('is-busy') || !public_vars.$pageContainer.hasClass(public_vars.sidebarCollapseClass))
      return;

    fit_main_content_height();

    var current_padding = parseInt(public_vars.$pageContainer.css('padding-left'), 10);

    // Check
    public_vars.$pageContainer.removeClass(public_vars.sidebarCollapseClass);

    const padding_left = parseInt(public_vars.$pageContainer.css('padding-left'), 10),
      $span_elements = public_vars.$mainMenu.find('li a span'),
      $submenus = public_vars.$mainMenu.find('.has-sub > ul'),
      $search_input = public_vars.$mainMenu.find('#search .search-input'),
      $search_button = public_vars.$mainMenu.find('#search button'),
      $logo_env = public_vars.$sidebarMenu.find('.logo-env'),
      $collapse_icon = $logo_env.find('.sidebar-collapse'),
      $logo = $logo_env.find('.logo'),
      $sidebar_ulink = public_vars.$sidebarUser.find('span, strong'),

      logo_env_padding = parseInt($logo_env.css('padding'), 10);


    // Return to normal state
    public_vars.$pageContainer.addClass(public_vars.sidebarCollapseClass);

    // Showing Class
    setTimeout(function () { public_vars.$pageContainer.addClass(public_vars.sidebarOnShowTransitionClass); }, 1);

    const padding_diff = padding_left - current_padding;

    // Start animation
    public_vars.$mainMenu.data('is-busy', true);

    public_vars.$pageContainer.addClass(public_vars.sidebarOnTransitionClass);


    public_vars.$pageContainer.animate({ paddingLeft: padding_left }, public_vars.sidebarTransitionTime);
    public_vars.$sidebarMenu.animate({ width: padding_left }, public_vars.sidebarTransitionTime);

    $logo_env.animate({ padding: logo_env_padding }, public_vars.sidebarTransitionTime);


    // Second Phase
    setTimeout(function () {
      //public_vars.$pageContainer.removeClass(public_vars.sidebarCollapseClass);
      $logo.css({ width: 'auto', height: 'auto' });

      TweenMax.set($logo, { css: { scaleY: 0 } });
      //TMPTweenMax.set($search_input, {css: {opacity: 0, visibility: 'visible'}});

      TweenMax.to($logo, (public_vars.sidebarTransitionTime / 2) / 1100, { css: { scaleY: 1 } });

      //TMP$search_input.transit({opacity: 1}, public_vars.sidebarTransitionTime);

      // Third Phase
      setTimeout(function () {

        public_vars.$pageContainer.removeClass(public_vars.sidebarCollapseClass);

        $submenus.hide().filter('.visible').slideDown('normal', function () {
          $submenus.attr('style', '');
        });

        public_vars.$pageContainer.removeClass(public_vars.sidebarOnShowTransitionClass);

        // Last Phase
        setTimeout(function () {
          // Reset Vars
          public_vars.$pageContainer
            .add(public_vars.$sidebarMenu)
            .add($logo_env)
            .add($logo)
            .add($span_elements)
            .add($submenus)
            .attr('style', '');

          public_vars.$pageContainer.removeClass(public_vars.sidebarOnTransitionClass);

          public_vars.$mainMenu.data('is-busy', false); // Transition End


          fit_main_content_height();

        }, public_vars.sidebarTransitionTime);


      }, public_vars.sidebarTransitionTime / 2);

    }, public_vars.sidebarTransitionTime / 2);
  }
}

function hide_sidebar_menu(with_animation) {
  if (isxs())
    return;

  // if (public_vars.isRightSidebar) {
  //   rb_hide_sidebar_menu(with_animation);
  //   return;
  // }

  if (!with_animation) {
    public_vars.$pageContainer.addClass(public_vars.sidebarCollapseClass);
  }
  else {
    if (public_vars.$mainMenu.data('is-busy') || public_vars.$pageContainer.hasClass(public_vars.sidebarCollapseClass))
      return;

    fit_main_content_height();

    const current_padding = parseInt(public_vars.$pageContainer.css('padding-left'), 10);

    // Check
    public_vars.$pageContainer.addClass(public_vars.sidebarCollapseClass);

    const padding_left = parseInt(public_vars.$pageContainer.css('padding-left'), 10),
      $span_elements = public_vars.$mainMenu.find('li a span'),
      $submenus = public_vars.$mainMenu.find('.has-sub > ul'),
      $search_input = public_vars.$mainMenu.find('#search .search-input'),
      $search_button = public_vars.$mainMenu.find('#search button'),
      $logo_env = public_vars.$sidebarMenu.find('.logo-env'),
      $collapse_icon = $logo_env.find('.sidebar-collapse'),
      $logo = $logo_env.find('.logo'),
      $sidebar_ulink = public_vars.$sidebarUser.find('span, strong'),

      logo_env_padding = parseInt($logo_env.css('padding'), 10);


    // Return to normal state
    public_vars.$pageContainer.removeClass(public_vars.sidebarCollapseClass);

    const padding_diff = current_padding - padding_left;

    // Start animation (1)
    public_vars.$mainMenu.data('is-busy', true);


    // Add Classes & Hide Span Elements
    public_vars.$pageContainer.addClass(public_vars.sidebarOnTransitionClass);
    setTimeout(function () { public_vars.$pageContainer.addClass(public_vars.sidebarOnHideTransitionClass); }, 1);

    TweenMax.to($submenus, public_vars.sidebarTransitionTime / 1100, { css: { height: 0 } });

    //TMP$search_input.transit({opacity: 0}, public_vars.sidebarTransitionTime);
    $search_button.animate({ right: padding_diff }, public_vars.sidebarTransitionTime);
    $logo.animate({ scale: [1, 0], perspective: 300/*, opacity: 0*/ }, public_vars.sidebarTransitionTime / 2);
    $logo_env.animate({ padding: logo_env_padding }, public_vars.sidebarTransitionTime);
    //$collapse_icon.transit({left: -padding_diff+3}, public_vars.sidebarTransitionTime * 5);

    // if (!rtl()) {
    //   TweenMax.to($collapse_icon, .5, { css: { left: -padding_diff + 3 }, delay: .1 });
    // }

    public_vars.$pageContainer.animate({ paddingLeft: padding_left }, public_vars.sidebarTransitionTime);

    TweenMax.set($sidebar_ulink, { css: { opacity: 0 } });


    setTimeout(function () {
      // In the end do some stuff
      public_vars.$pageContainer
        .add(public_vars.$sidebarMenu)
        .add($search_input)
        .add($search_button)
        .add($logo_env)
        .add($logo)
        .add($span_elements)
        .add($collapse_icon)
        .add($submenus)
        .add($sidebar_ulink)
        .add(public_vars.$mainMenu)
        .attr('style', '');

      public_vars.$pageContainer.addClass(public_vars.sidebarCollapseClass);

      public_vars.$mainMenu.data('is-busy', false);
      public_vars.$pageContainer.removeClass(public_vars.sidebarOnTransitionClass).removeClass(public_vars.sidebarOnHideTransitionClass);

      fit_main_content_height();

    }, public_vars.sidebarTransitionTime);
  }
}

function toggle_sidebar_menu(with_animation) {
  const open = public_vars.$pageContainer.hasClass(public_vars.sidebarCollapseClass);

  if (open) {
    show_sidebar_menu(with_animation);
  }
  else {
    hide_sidebar_menu();
  }
}








// Resizable setup

jQuery.extend(public_vars, {

  breakpoints: {
    largescreen: [991, -1],
    tabletscreen: [768, 990],
    devicescreen: [420, 767],
    sdevicescreen: [0, 419]
  },

  lastBreakpoint: null
});

// Get current breakpoint
function get_current_breakpoint() {
  var width = jQuery(window).width(),
    breakpoints = public_vars.breakpoints;

  for (var breakpont_label in breakpoints) {
    var bp_arr = breakpoints[breakpont_label],
      min = bp_arr[0],
      max = bp_arr[1];

    if (max == -1)
      max = width;

    if (min <= width && max >= width) {
      return breakpont_label;
    }
  }

  return null;
}

/* Main Function that will be called each time when the screen breakpoint changes */
function resizable(breakpoint) {
  var sb_with_animation;


  // Large Screen Specific Script
  if (is('largescreen')) {
    sb_with_animation = public_vars.$sidebarMenu.find(".sidebar-collapse-icon").hasClass('with-animation') || public_vars.$sidebarMenu.hasClass('with-animation');

    if (public_vars.$sidebarMenu.data('initial-state') == 'open') {
      show_sidebar_menu(sb_with_animation);
    }
    else {
      hide_sidebar_menu(sb_with_animation);
    }
  }


  // Tablet or larger screen
  if (ismdxl()) {
    public_vars.$mainMenu.attr('style', '');
  }


  // Tablet Screen Specific Script
  if (is('tabletscreen')) {
    sb_with_animation = public_vars.$sidebarMenu.find(".sidebar-collapse-icon").hasClass('with-animation') || public_vars.$sidebarMenu.hasClass('with-animation');

    hide_sidebar_menu(sb_with_animation);
  }


  // Tablet Screen Specific Script
  if (isxs()) {
    public_vars.$pageContainer.removeClass('sidebar-collapsed');
  }


  // Fit main content height
  fit_main_content_height();
}

// Check current screen breakpoint
function is(screen_label) {
  return get_current_breakpoint() == screen_label;
}

// Is xs device
function isxs() {
  return is('devicescreen') || is('sdevicescreen');
}

// Is md or xl
function ismdxl() {
  return is('tabletscreen') || is('largescreen');
}
// Trigger Resizable Function
function trigger_resizable() {
  if (public_vars.lastBreakpoint != get_current_breakpoint()) {
    public_vars.lastBreakpoint = get_current_breakpoint();
    resizable(public_vars.lastBreakpoint);
  }
}

// Select2 Plugin
function initSelect2Plugin() {
  $.fn.select2 && $('[data-init-plugin="select2"]').each(function () {
    $(this).select2({
      minimumResultsForSearch: ($(this).attr('data-disable-search') == 'true' ? -1 : 1)
    }).on('select2-opening', function () {
      $.fn.scrollbar && $('.select2-results').scrollbar({
        ignoreMobile: false
      })
    });
  });
}
