var current_tile;
var current_cell;

var make_tray_tiles_draggable = function() {
  return $('#tray .tile').draggable({
    snap: '.cell',
    revert: 'invalid'
  });
};

var make_cells_droppable = function() {
  $('.cell').droppable({
    drop: function() {
      current_tile.css( {left: '0px', top: '0px'} );
      current_tile.detach().appendTo(this);
    }
  });
};

var on_tile_grab = function(f) { $('.tile').on( 'mousedown', f ) };
var define_current_tile = function(e) {
  // e.preventDefault();
  current_tile = $(this);
  console.log(current_tile);
};

// var on_enter_cell = function(f) { $('.cell').on( 'mouseenter', f ) };
// var define_current_cell = function(e) {
//   // e.preventDefault();
//   current_cell = $(this);
//   console.log(current_cell);
// };

// var on_drop_tile = function(e) {
  // listen for tile drop event
  // trigger detach/appentTo response


// }



$('#tray .tile').first().detach().appendTo($('#cell_0x0'))

$(function() {
  make_tray_tiles_draggable();
  make_cells_droppable();
  on_tile_grab( define_current_tile );
});
