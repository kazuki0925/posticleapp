function modal() {
  const pullDownButton = document.getElementById("img-menu-icon")
  const modalMenu = document.getElementById("modal-menu")

  pullDownButton.addEventListener('click', function(){
    if (modalMenu.getAttribute("class") == "hidden") {
      modalMenu.removeAttribute("class", "hidden")
    } else {
      modalMenu.setAttribute("class", "hidden")
    }
  })
}

window.addEventListener('load', modal)