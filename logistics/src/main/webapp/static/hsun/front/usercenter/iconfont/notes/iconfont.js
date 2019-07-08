;(function(window) {

  var svgSprite = '<svg>' +
    '' +
    '<symbol id="icon-tubiaozongjie22" viewBox="0 0 1054 1024">' +
    '' +
    '<path d="M937.386743 152.541292l30.52912 30.568234-537.098678 537.098678-97.565408 10.834806 0 13.520691-24.498918 0 0-24.355497 13.566325 0 10.932593-97.656676 537.000891-537.144312 30.483486 30.431333L937.386743 152.541292 937.386743 152.541292zM967.915862 0l-61.05172 48.854414 97.747944 97.611042 48.756627-61.05172L967.915862 0 967.915862 0zM967.915862 0"  ></path>' +
    '' +
    '<path d="M817.917034 1023.973923 182.503247 1023.973923C81.880364 1023.973923 0 942.054445 0 841.425043l0-635.420306C0 105.47964 81.880364 23.553643 182.503247 23.553643l545.664825 0c17.953704 0 32.458784 14.557233 32.458784 32.458784 0 17.953704-14.511599 32.458784-32.458784 32.458784L182.503247 88.471211c-64.819782 0-117.585678 52.66811-117.585678 117.585678l0 635.46594c0 64.819782 52.713744 117.579159 117.585678 117.579159l635.413787 0c64.917569 0 117.631312-52.759378 117.631312-117.579159l0-538.089587c0-17.901551 14.518119-32.458784 32.458784-32.458784s32.41315 14.550714 32.41315 32.458784l0 537.9918C1000.420281 942.054445 918.539917 1023.973923 817.917034 1023.973923L817.917034 1023.973923zM817.917034 1023.973923"  ></path>' +
    '' +
    '</symbol>' +
    '' +
    '</svg>'
  var script = function() {
    var scripts = document.getElementsByTagName('script')
    return scripts[scripts.length - 1]
  }()
  var shouldInjectCss = script.getAttribute("data-injectcss")

  /**
   * document ready
   */
  var ready = function(fn) {
    if (document.addEventListener) {
      if (~["complete", "loaded", "interactive"].indexOf(document.readyState)) {
        setTimeout(fn, 0)
      } else {
        var loadFn = function() {
          document.removeEventListener("DOMContentLoaded", loadFn, false)
          fn()
        }
        document.addEventListener("DOMContentLoaded", loadFn, false)
      }
    } else if (document.attachEvent) {
      IEContentLoaded(window, fn)
    }

    function IEContentLoaded(w, fn) {
      var d = w.document,
        done = false,
        // only fire once
        init = function() {
          if (!done) {
            done = true
            fn()
          }
        }
        // polling for no errors
      var polling = function() {
        try {
          // throws errors until after ondocumentready
          d.documentElement.doScroll('left')
        } catch (e) {
          setTimeout(polling, 50)
          return
        }
        // no errors, fire

        init()
      };

      polling()
        // trying to always fire before onload
      d.onreadystatechange = function() {
        if (d.readyState == 'complete') {
          d.onreadystatechange = null
          init()
        }
      }
    }
  }

  /**
   * Insert el before target
   *
   * @param {Element} el
   * @param {Element} target
   */

  var before = function(el, target) {
    target.parentNode.insertBefore(el, target)
  }

  /**
   * Prepend el to target
   *
   * @param {Element} el
   * @param {Element} target
   */

  var prepend = function(el, target) {
    if (target.firstChild) {
      before(el, target.firstChild)
    } else {
      target.appendChild(el)
    }
  }

  function appendSvg() {
    var div, svg

    div = document.createElement('div')
    div.innerHTML = svgSprite
    svgSprite = null
    svg = div.getElementsByTagName('svg')[0]
    if (svg) {
      svg.setAttribute('aria-hidden', 'true')
      svg.style.position = 'absolute'
      svg.style.width = 0
      svg.style.height = 0
      svg.style.overflow = 'hidden'
      prepend(svg, document.body)
    }
  }

  if (shouldInjectCss && !window.__iconfont__svg__cssinject__) {
    window.__iconfont__svg__cssinject__ = true
    try {
      document.write("<style>.svgfont {display: inline-block;width: 1em;height: 1em;fill: currentColor;vertical-align: -0.1em;font-size:16px;}</style>");
    } catch (e) {
      console && console.log(e)
    }
  }

  ready(appendSvg)


})(window)