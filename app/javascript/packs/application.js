// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("datatables.net");
require("datatables.net-dt");

import jquery from 'jquery';
window.$ = window.jquery = jquery;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import 'bootstrap'
import 'gsap'

import './plugins/bootstrap_custom.js'
import './main.js'
import { initComponentDataTable } from "./plugins/datatable.js";
import { initSelect2 } from "./plugins/init_select2.js";
import '../components/utils.js';

// Plugins
initComponentDataTable();
initSelect2();
