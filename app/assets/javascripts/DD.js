function dragDefine(ev) {
    ev.dataTransfer.effectAllowed = 'move';
    ev.dataTransfer.setData("text/plain", ev.target.getAttribute('id'));
    ev.dataTransfer.setDragImage(ev.target, 0, 0);
    return true;
    }

function dragOver(ev) {
    ev.preventDefault();
    }

function dragEnd(ev) {
    return true;
    }

function dragDrop(ev) {
    var idDrag = ev.dataTransfer.getData("Text");
    ev.target.appendChild(document.getElementById(idDrag));
    ev.preventDefault();
    }
