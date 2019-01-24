// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

((global) => {
  'use strict'
  const {log} = console
  const {random} = Math

  $(document).on('turbolinks:load', () => {
    $('.glyphicon-remove').click(() => { $('.error-msg').css('display', 'none') })
    load()
    $('#search').click(() => { $('iframe').attr('src', `https://www.weblio.jp/content/${$('input[type="text"]').val()}`);  })
    $('.navbar-fixed-bottom').click(() => { history.back() })
   })

  const load = () => {
    'use strict'

    const canvas = document.getElementsByTagName('canvas')[0]
    const ctx = canvas.getContext("2d")

    const resize = () => {
      canvas.width = global.innerWidth || document.documentElement.clientWidth || document.body.clientWidth
      canvas.height = global.innerHeight || document.documentElement.clientHeight || document.body.clientHeight
    }

    resize()
    global.onresize = resize

    // requestAnimationFrame
    const RAF = (() => { return global.requestAnimationFrame ||
        global.webkitRequestAnimationFrame ||
        global.mozRequestAnimationFrame ||
        global.oRequestAnimationFrame ||
        global.msRequestAnimationFrame ||
        function (callback) { global.setTimeout(callback, 1000 / 60)}
    })()

    let mouse = {x: null, y: null, max: 20000}
    global.onmousemove = (e = global.event) => { [mouse.x, mouse.y] = [e.clientX, e.clientY] }
    global.onmouseout = (e) => { [mouse.x, mouse.y].map(_ => null) }

    let dots = []
    Array(300).fill(0).forEach(() => { dots.push({
      x: random() * canvas.width,
      y: random() * canvas.height,
      xa: random() * 2 - 1,
      ya: random() * 2 - 1,
      max: 6000,
    })})

    setTimeout(animate, 100)

    function animate () {
      ctx.clearRect(0, 0, canvas.width, canvas.height)
      let mdots = [mouse].concat(dots)

      dots.forEach((dot) => {
        dot.x += dot.xa
        dot.y += dot.ya
        if ( dot.x > canvas.width || dot.x < 0 ) dot.xa *= -1
        if ( dot.y > canvas.height || dot.y < 0 ) dot.ya *= -1

        ctx.fillRect(dot.x - 0.5, dot.y - 0.5, 1, 1)
        mdots.forEach((otherDot)=>{
          let d2 = otherDot
          if ((dot !== d2 && d2.x && d2.y)) {
            let dis = (dot.x - d2.x)**2 + (dot.y - d2.y)**2
            if (dis < d2.max) {
              if (d2 === mouse && dis > (d2.max / 2)) {
                dot.x -= (dot.x - d2.x) * 0.03
                dot.y -= (dot.y - d2.y) * 0.03
              }
              let ratio = (d2.max - dis) / d2.max

              ctx.beginPath()
              ctx.lineWidth = ratio / 2
              ctx.strokeStyle = `rgba(0,0,0,${ratio + 0.2})`
              ctx.moveTo(dot.x, dot.y)
              ctx.lineTo(d2.x, d2.y)
              ctx.stroke()
            }
          }
        })
        mdots.splice(mdots.indexOf(dot), 1)
      })
      RAF(animate)
    }
  }
})(window)
