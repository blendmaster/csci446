(function(){
  var canvas, width, height, ctx, stop, end, move_delay, std_dev, difficulty_curve, people, trampoline, points, mistakes, drop_position, next_person, draw, tick, drop_animation, game_over, start_game, move, key_move, click_move;
  canvas = document.getElementById('canvas');
  width = canvas.width, height = canvas.height;
  ctx = canvas.getContext('2d');
  window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || window.oRequestAnimationFrame || function(it){
    return window.setTimeout(it, 1000 / 60);
  };
  stop = [5, 13, 19];
  end = 21;
  move_delay = 43;
  std_dev = 5;
  difficulty_curve = Math.pow(Math.E, Math.log(2 / 100));
  people = void 8;
  trampoline = void 8;
  points = void 8;
  mistakes = void 8;
  drop_position = void 8;
  next_person = void 8;
  draw = function(){
    var i, p, _ref, _len;
    ctx.clearRect(0, 0, width, height);
    ctx.fillText("trampoline: " + stop[trampoline], 0, 20);
    ctx.fillText("points: " + points, 100, 20);
    ctx.fillText("mistakes: " + mistakes, 150, 20);
    for (i = 0, _len = (_ref = people).length; i < _len; ++i) {
      p = _ref[i];
      ctx.fillText("person: " + p.position, p.position, 50 + 15 * i);
    }
  };
  tick = function(){
    var dropped, dirty, p, pos, avg, i, _i, _ref, _len;
    dropped = false;
    dirty = false;
    for (_i = 0, _len = (_ref = people).length; _i < _len; ++_i) {
      p = _ref[_i];
      if (--p.delay === 0) {
        dirty = true;
        p.delay = move_delay;
        pos = p.position++;
        if (stop.indexOf(pos) !== -1) {
          if (!p.bounced) {
            if (++mistakes === 3) {
              return game_over();
            }
            dropped = p;
            break;
          }
          p.bounced = false;
        }
      }
      if (p.position === stop[trampoline]) {
        p.bounced = true;
      }
    }
    if (dropped) {
      people.splice(people.indexOf(dropped), 1);
      drop_position = pos;
      document.removeEventListener('keydown', key_move);
      canvas.removeEventListener('click', click_move);
      drop_animation();
    } else {
      if (((_ref = people[0]) != null ? _ref.position : void 8) === end) {
        ++points;
        people.shift();
      }
      if (--next_person === 0) {
        people.push({
          position: 0,
          delay: move_delay
        });
        avg = 0;
        for (i = 0; i < 16; ++i) {
          avg += Math.random() * 2 - 1;
        }
        avg /= 16;
        next_person = (_ref = Math.floor((avg * std_dev + end / 2 - Math.pow(difficulty_curve, points)) * move_delay)) > move_delay ? _ref : move_delay;
      }
      if (dirty) {
        draw();
      }
      window.requestAnimationFrame(tick);
    }
  };
  drop_animation = function(){
    draw();
    ctx.fillText("dropped!", 150, 150);
    setTimeout(function(){
      document.addEventListener('keydown', key_move);
      canvas.addEventListener('click', click_move);
      next_person = 1;
      draw();
      return tick();
    }, 1000);
  };
  game_over = function(){
    draw();
    ctx.fillText("game over!", 150, 130);
    ctx.fillText("click to start game", 150, 150);
    document.removeEventListener('keydown', key_move);
    canvas.removeEventListener('click', click_move);
    canvas.addEventListener('click', start_game);
  };
  start_game = function(){
    people = [{
      position: 0,
      delay: move_delay
    }];
    trampoline = 1;
    points = 0;
    mistakes = 0;
    next_person = end * move_delay;
    document.addEventListener('keydown', key_move);
    canvas.addEventListener('click', click_move);
    canvas.removeEventListener('click', start_game);
    draw();
    tick();
  };
  move = {
    81: 0,
    87: 1,
    69: 2
  };
  key_move = function(e){
    var keyCode, that;
    keyCode = e.keyCode;
    if (keyCode === 37 && trampoline > 0) {
      --trampoline;
    } else if (keyCode === 39 && trampoline < 2) {
      ++trampoline;
    } else {
      if ((that = move[keyCode]) != null) {
        trampoline = that;
      }
    }
    console.log(trampoline);
    console.log(keyCode);
    draw();
    e.preventDefault();
  };
  click_move = function(e){
    var x;
    x = e.clientX;
    trampoline = Math.floor(x / width * 3);
    draw();
    e.preventDefault();
  };
  ctx.fillText("click to start game", 150, 150);
  canvas.addEventListener('click', start_game);
}).call(this);
