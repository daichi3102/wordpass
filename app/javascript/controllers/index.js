// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"

import HelloController from "./hello_controller"
import LoadingController from "./loading_controller"
import TabsController from "./tabs_controller"

const application = Application.start()
application.register("hello", HelloController)
application.register("loading", LoadingController)
application.register("tabs", TabsController)
