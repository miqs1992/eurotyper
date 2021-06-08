import SlimSelect from 'slim-select'
import "slim-select/dist/slimselect.min.css"

window.onload = () => {
  new SlimSelect({
    select: '#team-select'
  });
  new SlimSelect({
    select: '#player-select'
  });
}
