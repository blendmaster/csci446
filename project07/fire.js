(function(){
  window.addEventListener('load', function(){
    var canvas, width, height, ctx, assets, img, stop, end, move_delay, trampoline_delay, std_dev, difficulty_curve, that, high_scores, high_score_threshold, add_high_score, high_scores_el, hide_high_scores, show_high_scores, people, trampoline, points, misses, next_person, frame, draw, tick, walk_off_positions, drop_animation, game_over, start_game, click_start, key_move, click_move, pause, click_unpause, current_title, cycle_timeout, cycle_frame, cycle_title, _i, _ref, _len;
    canvas = document.getElementById('canvas');
    width = canvas.width, height = canvas.height;
    ctx = canvas.getContext('2d');
    assets = {};
    for (_i = 0, _len = (_ref = document.getElementById('assets').children).length; _i < _len; ++_i) {
      img = _ref[_i];
      assets[img.id] = img;
    }
    ctx.render = function(it){
      return this.drawImage(assets[it] || (function(){
        throw new Error("asset " + it + " doesn't exist!");
      }()), 0, 0);
    };
    window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame || window.oRequestAnimationFrame || function(it){
      return window.setTimeout(it, 1000 / 60);
    };
    window.cancelAnimationFrame = window.cancelAnimationFrame || window.mozCancelAnimationFrame || window.webkitCancelAnimationFrame || window.msCancelAnimationFrame || window.oCancelAnimationFrame || function(it){
      return window.clearTimeout(it);
    };
    stop = [4, 12, 18];
    end = 21;
    move_delay = 40;
    trampoline_delay = 8;
    std_dev = 5;
    difficulty_curve = Math.pow(Math.E, Math.log(2 / 5));
    if (that = typeof localStorage != 'undefined' && localStorage !== null ? localStorage['high_scores'] : void 8) {
      high_scores = JSON.parse(that);
    } else {
      high_scores = [
        {
          name: 'mario',
          score: 384
        }, {
          name: 'luigi',
          score: 253
        }, {
          name: 'wario',
          score: 231
        }, {
          name: 'bowser',
          score: 133
        }, {
          name: 'toad',
          score: 27
        }
      ];
    }
    high_score_threshold = high_scores.reduce(function(a, b){
      if (a.score < b.score) {
        return a;
      } else {
        return b;
      }
    }).score;
    add_high_score = function(points){
      high_scores.push({
        name: window.prompt('You got a high score! enter your name:').substr(0, 10) || 'anonymous',
        score: points
      });
      high_scores = high_scores.sort(function(a, b){
        return b.score - a.score;
      }).slice(0, 5);
      if (localStorage) {
        localStorage['high_scores'] = JSON.stringify(high_scores);
      }
    };
    high_scores_el = document.getElementById('high-scores');
    hide_high_scores = function(){
      return high_scores_el.hidden = true;
    };
    show_high_scores = function(){
      var list, h, _i, _ref, _len;
      list = '';
      for (_i = 0, _len = (_ref = high_scores).length; _i < _len; ++_i) {
        h = _ref[_i];
        list += "<li>" + h.name + " : " + h.score + "</li>";
      }
      high_scores_el.innerHTML = list;
      high_scores_el.hidden = false;
    };
    people = void 8;
    trampoline = void 8;
    points = void 8;
    misses = void 8;
    next_person = void 8;
    frame = void 8;
    draw = function(){
      var p, _i, _ref, _len;
      ctx.clearRect(0, 0, width, height);
      ctx.render('bg');
      ctx.font = '12px "Gloria Hallelujah"';
      ctx.fillText(points, 155, 16);
      if (misses > 0) {
        ctx.render(misses + "miss");
      }
      ctx.render("tramp" + trampoline);
      for (_i = 0, _len = (_ref = people).length; _i < _len; ++_i) {
        p = _ref[_i];
        ctx.render(p.position.toString());
      }
    };
    tick = function(){
      var dropped, dirty, tramp, p, prev, pos, avg, i, _i, _ref, _len;
      dropped = false;
      dirty = false;
      tramp = stop[trampoline];
      for (_i = 0, _len = (_ref = people).length; _i < _len; ++_i) {
        p = _ref[_i];
        if (--p.delay <= 0) {
          dirty = true;
          p.delay = move_delay;
          prev = p.position;
          pos = ++p.position;
          if (stop.indexOf(pos) !== -1) {
            if (pos !== tramp) {
              p.death_timer = trampoline_delay;
            }
          }
          if (stop.indexOf(prev) !== -1) {
            ++points;
            p.bounced = false;
          }
        }
        if (p.death_timer) {
          if (--p.death_timer === 0) {
            ++misses;
            dropped = p;
            break;
          }
        }
        if (p.position === tramp) {
          p.bounced = true;
          p.death_timer = 0;
        }
      }
      if (dropped) {
        people.splice(people.indexOf(dropped), 1);
        drop_animation(p.position);
      } else {
        if (((_ref = people[0]) != null ? _ref.position : void 8) === end) {
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
        frame = window.requestAnimationFrame(tick);
      }
    };
    walk_off_positions = {
      4: 0,
      12: 2,
      18: 3
    };
    drop_animation = function(drop_position){
      var walk_pos;
      document.removeEventListener('keydown', key_move);
      canvas.removeEventListener('click', click_move);
      draw();
      ctx.render("miss" + drop_position);
      walk_pos = walk_off_positions[drop_position];
      setTimeout((function(){
        function walk_anim(){
          draw();
          ctx.render("walk" + walk_pos);
          if (++walk_pos < 5) {
            return setTimeout(walk_anim, 500);
          } else {
            if (misses === 3) {
              return game_over();
            }
            return setTimeout(function(){
              document.addEventListener('keydown', key_move);
              canvas.addEventListener('click', click_move);
              next_person = 1;
              draw();
              return tick();
            }, 500);
          }
        }
        return walk_anim;
      }()), 500);
    };
    game_over = function(){
      var cycles, current_gameover, cycle_gameover;
      if (points > high_score_threshold) {
        add_high_score(points);
      }
      show_high_scores();
      document.removeEventListener('keydown', key_move);
      canvas.removeEventListener('click', click_move);
      canvas.addEventListener('click', click_start);
      cycles = 50;
      current_gameover = 0;
      ctx.drawImage(assets.gameover1, 0, 0, width, height);
      cycle_gameover = function(){
        ctx.clearRect(0, 0, width, height);
        current_gameover = (current_gameover + 1) % 3;
        ctx.drawImage(assets["gameover" + (current_gameover + 1)], 0, 0, width, height);
        if (--cycles > 0) {
          window.setTimeout(cycle_gameover, 100);
        } else {
          cycle_title();
        }
      };
      window.setTimeout(cycle_gameover, 100);
    };
    start_game = function(){
      people = [{
        position: 0,
        delay: move_delay
      }];
      trampoline = 1;
      points = 0;
      misses = 0;
      next_person = end * move_delay;
      window.clearTimeout(cycle_timeout);
      window.cancelAnimationFrame(cycle_frame);
      document.addEventListener('keydown', key_move);
      canvas.addEventListener('click', click_move);
      canvas.removeEventListener('click', click_start);
      hide_high_scores();
      draw();
      tick();
    };
    click_start = function(e){
      var button;
      button = e.button;
      if (button === 0) {
        e.preventDefault();
        return start_game();
      }
    };
    key_move = function(e){
      var keyCode;
      keyCode = e.keyCode;
      if (keyCode === 37 && trampoline > 0) {
        --trampoline;
      } else if (keyCode === 39 && trampoline < 2) {
        ++trampoline;
      } else if (keyCode === 27) {
        pause();
      }
      draw();
      e.preventDefault();
    };
    click_move = function(e){
      var clientX, clientY, left, top, x, y, _ref;
      clientX = e.clientX, clientY = e.clientY;
      _ref = canvas.getBoundingClientRect(), left = _ref.left, top = _ref.top;
      x = clientX - left;
      y = clientY - top;
      if (x > 208 && y < 38) {
        pause();
      } else if (25 < x && x < 97) {
        trampoline = 0;
      } else if (97 < x && x < 156) {
        trampoline = 1;
      } else if (156 < x && x < 236) {
        trampoline = 2;
      }
      draw();
      e.preventDefault();
    };
    pause = function(){
      window.cancelAnimationFrame(frame);
      setTimeout(function(){
        ctx.clearRect(0, 0, width, height);
        return ctx.render('pause');
      }, 0);
      document.removeEventListener('keydown', key_move);
      canvas.removeEventListener('click', click_move);
      canvas.addEventListener('click', click_unpause);
    };
    click_unpause = function(){
      canvas.removeEventListener('click', click_unpause);
      document.addEventListener('keydown', key_move);
      canvas.addEventListener('click', click_move);
      tick();
    };
    current_title = 0;
    cycle_timeout = void 8;
    cycle_frame = void 8;
    cycle_title = function(){
      ctx.clearRect(0, 0, width, height);
      current_title = (current_title + 1) % 3;
      ctx.drawImage(assets["title" + (current_title + 1)], 0, 0, width, height);
      cycle_frame = window.requestAnimationFrame(function(){
        return cycle_timeout = setTimeout(cycle_title, 100);
      });
    };
    cycle_title();
    show_high_scores();
    return canvas.addEventListener('click', click_start);
  });
}).call(this);
