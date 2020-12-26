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
  connect(){

  }
  
  addToCart(e) {
    e.preventDefault();
    
  }
}
    // console.log('go');
