
// dragDefine - called when an item starts to be dragged
function dragDefine(ev) {
    ev.dataTransfer.effectAllowed = 'move';
    ev.dataTransfer.setData("text/plain", ev.target.getAttribute('id'));
    ev.dataTransfer.setDragImage(ev.target, 0, 0);
    return true;
    }

// dragOver - called when the item being dragged is over another item
function dragOver(ev) {
    // Get the id of the item being dragged
    //var idDrag = ev.dataTransfer.getData("Text");
    // Get the id of the item the dragged object is currently over
    //var idBox = ev.target.getAttribute('id');
    // You may want to perform some checks here, e.g. is the dragged item allowed to be dropped here for example

    // Turn off the default behaviour i.e. allow the drop
    ev.preventDefault();
    }

// dragEnd - called when the drag is complete
function dragEnd(ev) {
    return true;
    }

// dragDrop - called when the item being dragged is dropped
function dragDrop(ev) {
    // Get the id of the item being dragged
    var idDrag = ev.dataTransfer.getData("Text");
    // Append the dragged item to the item it is currently over
    ev.target.appendChild(document.getElementById(idDrag));
    // Turn off the default behaviour
    ev.preventDefault();
    }
