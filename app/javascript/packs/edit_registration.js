import SlimSelect from 'slim-select'
import "slim-select/dist/slimselect.min.css"

window.onload = () => {
  if(document.getElementById("team-select")){
    new SlimSelect({ select: '#team-select' });
    new SlimSelect({ select: '#player-select' });
  }
}
