// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import ax from 'axios'
//import'axios'模組 叫做ax
import magicRails from "@rails/ujs"

export default class extends Controller {
  static targets = [ "icon" ]

  go(e) {
    e.preventDefault();
    const id = this.data.get('id')

    magicRails.ajax({
      url: `/posts/${id}/favorite`,
      type: 'post',
      success: (resp) => {
        if (resp.status == "added") {
          this.iconTarget.classList.remove("far")
          this.iconTarget.classList.add("fas")
        } else {
          this.iconTarget.classList.remove("fas")
          this.iconTarget.classList.add("far")
        }
      },
      error: function(err) {
        console.log(err);
      }
    })

    // const token = document.querySelector('[name=csrf-token]').content
    // ax.defaults.headers.common['X-CSRF-TOKEN'] = token

    // ax.post(`/posts/${id}/favorite`, {})
    //   .then((resp) => {
    //     console.log(resp);
    //     if (resp.data.status == "added") {
    //       this.iconTarget.classList.remove("far")
    //       this.iconTarget.classList.add("fas")
    //     } else {
    //       this.iconTarget.classList.remove("fas")
    //       this.iconTarget.classList.add("far")
    //     }
    //   })
      // .then((resp) => {
      //   console.log(resp);
      //   if (resp.data.status == "added") {
      //     icon.iconTarget.classList.remove("far")
      //     icon.iconTarget.classList.add("fas")
      //   } else {
      //     icon.iconTarget.classList.remove("fas")
      //     icon.iconTarget.classList.add("far")
      //   }
      // })
//       .catch(function(err) {
//         console.log(err);
//       })
  }
}
