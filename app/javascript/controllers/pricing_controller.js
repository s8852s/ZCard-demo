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
  static targets = []

  addToCart(e) {
    e.preventDefault();
    const productId = this.data.get('id')
    // const productId = e.currentTarget.dataset.product

    Rails.ajax({
      url: `/cart/add_item/${productId}`,
      type: 'post',
      success: (resp) => {
        // 通知右上角演戲
        const event = new CustomEvent('abc', {
          detail: {
            aa: 1,
            bb: 2
          }
        })
        document.dispatchEvent(event)
        console.log(resp);
      },
      error: (err) => {
        console.log(err);
      }
    })
  }
}
    // console.log('go');
