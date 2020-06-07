import { Controller } from "stimulus"
import Sortable from "sortablejs";

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.savePositions.bind(this)
    });
  }

  savePositions(event){
    let id = event.item.dataset.id;
    let newIndex = event.newIndex + 1;

    $.ajax({
      url: this.data.get('url').replace(':id', id),
      method: 'PATCH',
      data: {
        dashboard: {
          position: newIndex
        }
      },
    })
  }
}
