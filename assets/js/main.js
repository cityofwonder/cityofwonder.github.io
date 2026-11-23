// Helpers the page scripts share -- loaded in <head>, before any of them.

// The page's scroll position
function getScrollPos() {
  return { x: window.scrollX, y: window.scrollY };
}

var _scrollTimer = [];

// Smooth scroll
function smoothScrollTo(y, time) {
  time = time == undefined ? 500 : time;

  var scrollPos = getScrollPos();
  var count = 60;
  var length = (y - scrollPos.y);

  function easeInOut(k) {
    return .5 * (Math.sin((k - .5) * Math.PI) + 1);
  }

  for (var i = _scrollTimer.length - 1; i >= 0; i--) {
    clearTimeout(_scrollTimer[i]);
  }

  for (var i = 0; i <= count; i++) {
    (function() {
      var cur = i;
      _scrollTimer[cur] = setTimeout(function() {
        window.scrollTo(
          scrollPos.x,
          scrollPos.y + length * easeInOut(cur/count)
        );
      }, (time / count) * cur);
    })();
  }
}

// A string's 32-bit hash: the seed of everything drawn "the same for the
// same input" -- a tag's colour (extensions/tag-colors.html), a post's page
// art (extensions/page-art.html), a hero's bits (extensions/hero-bits.html),
// a folder's peeker (_layouts/categories.html).
function strHash(s) {
  var h = 0;
  s = String(s == null ? '' : s);
  for (var i = 0; i < s.length; i++) h = (h * 31 + s.charCodeAt(i)) | 0;
  return h;
}

// Keeps .is-clipped-left / -right (axis 'x') or -top / -bottom ('y') on a
// scroller while its content runs on past that edge, for the CSS to fade the
// edge. Follows its scrolling and the window's size; returns the update, for
// a caller that moves it by hand.
function markClipped(el, axis) {
  var y = axis === 'y';
  function update() {
    var pos = y ? el.scrollTop : el.scrollLeft;
    var max = y ? el.scrollHeight - el.clientHeight : el.scrollWidth - el.clientWidth;
    el.classList.toggle(y ? 'is-clipped-top' : 'is-clipped-left', pos > 2);
    el.classList.toggle(y ? 'is-clipped-bottom' : 'is-clipped-right', pos < max - 2);
  }
  el.addEventListener('scroll', update, { passive: true });
  window.addEventListener('resize', update);
  window.addEventListener('load', update);
  update();
  return update;
}
