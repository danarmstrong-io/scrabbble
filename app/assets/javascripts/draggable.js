var make_tray_tiles_draggable = function() {
  return $('#tray .tile').draggable({
    snap: '.cell',
    revert: 'invalid'
  });
};

var make_board_cells_droppable = function() {
  return $('#board .cell').droppable({
  });
};

var make_tray_droppable = function() {
  return $('#tray').droppable({
  });
};

$(function() {
  alert('page is ready');
  make_tray_tiles_draggable();
  make_tray_tiles_draggable();
  make_board_cells_droppable();
});