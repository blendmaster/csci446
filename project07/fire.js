(function(){
  var canvas, width, height, ctx, stop, end, move_delay, people, trampoline, points, mistakes, tick, game_over, start_game, move, key_move, click_move;
  canvas = document.getElementById('canvas');
  width = canvas.width, height = canvas.height;
  ctx = canvas.getContext('2d');
  window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || window.oRequestAnimationFrame || function(it){
    return window.setTimeout(it, 1000 / 60);
  };
  stop = [4, 12, 18];
  end = 100;
  move_delay = 60;
  people = void 8;
  trampoline = void 8;
  points = void 8;
  mistakes = void 8;
  tick = function(){
    var next_people, p, pos, _i, _ref, _len;
    ctx.clearRect(0, 0, width, height);
    ctx.fillText("trampoline: " + trampoline, 0, 20);
    next_people = [];
    for (_i = 0, _len = (_ref = people).length; _i < _len; ++_i) {
      p = _ref[_i];
      if (--p.delay === 0) {
        p.delay = move_delay;
        pos = p.position++;
        if (stop.indexOf(pos) !== -1) {
          if (!p.bounced) {
            if (++mistakes > 3) {
              return game_over();
            }
          }
          p.bounced = false;
        }
      }
      if (p.position === trampoline) {
        p.bounced = true;
      }
      if (p.position > end) {
        ++points;
      } else {
        next_people.push(p);
        ctx.fillText("person: " + p.position, p.position, 50);
      }
    }
    people = next_people;
    window.requestAnimationFrame(tick);
  };
  game_over = function(){
    document.removeEventListener('keydown', key_move);
    canvas.removeEventListener('click', click_move);
    canvas.addEventListener('click', start_game);
  };
  start_game = function(){
    people = [{
      position: 0,
      delay: move_delay
    }];
    trampoline = stop[1];
    points = 0;
    mistakes = 0;
    document.addEventListener('keydown', key_move);
    canvas.addEventListener('click', click_move);
    canvas.removeEventListener('click', start_game);
    window.requestAnimationFrame(tick);
  };
  move = {
    81: stop[0],
    87: stop[1],
    69: stop[2]
  };
  key_move = function(e){
    var keyCode;
    keyCode = e.keyCode;
    trampoline = move[keyCode];
    e.preventDefault();
  };
  click_move = function(e){
    var x;
    x = e.clientX;
    trampoline = stop[Math.floor(x / width * 3)];
    e.preventDefault();
  };
  canvas.addEventListener('click', start_game);
}).call(this);
