// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";
import { Sortable, Droppable, Plugins } from "@shopify/draggable";

let Hooks = {};

Hooks.Sortable = {
  mounted() {
    const sortable = new Sortable(this.el, {
      draggable: ".sortable",
      mirror: {
        appendTo: this.el,
        constrainDimensions: true,
      },
      classes: {
        "draggable:over": ["drag-ghost"],
        "source:dragging": ["ghost-item"],
      },
    });

    // --- Draggable events --- //
    // sortable.on("drag:start", (evt) => {
    //   console.log("drag:start", evt);
    // });

    // sortable.on("drag:stop", (evt) => {
    //   console.log("drag:stop", evt);

    // });

    // sortable.on("drag:move", (evt) => {
    //   console.log("drag:move", evt);
    // });

    // sortable.on("drag:stopped", (evt) => {
    //   console.log("drag:stopped", evt);
    // });

    // sortable.on("draggable:destroy", (evt) => {
    //   console.log("draggable:destroy", evt);
    // });
  },
};

let dropzones = [];

Hooks.Droppable = {
  mounted() {
    dropzones.push(this.el);
    this.el.ondrop = (event) => {
      console.log("ondrop", event);
      event.preventDefault();
      const entity = JSON.parse(event.dataTransfer.getData("text/plain"));
      const window = event.target.getAttribute("phx-value-window");

      if (entity && entity.id && entity.event && window) {
        this.pushEvent(entity.event, {
          window: +window,
          ...entity,
        });
      } else {
        console.error("Invalid entity", entity);
      }
    };

    this.el.ondragover = (event) => {
      event.currentTarget.classList.remove("bg-none");
      event.currentTarget.classList.add("bg-blue-900");
    };

    this.el.ondragleave = (event) => {
      event.currentTarget.classList.remove("bg-blue-900");
      event.currentTarget.classList.add("bg-none");
    };
  },
};

Hooks.ResizeUp = {
  mounted() {
    this.el.onmousedown = (event) => {
      console.log("onmousedown", event);
    };
  },
};

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

window.dragStart = (event) => {
  event.currentTarget.classList.add("drag-ghost");

  console.log("dragStartingggg", event.target.id);

  console.log("event", event.target.dataset.id);

  event.dataTransfer.setData(
    "text/plain",
    JSON.stringify({
      id: event.target.dataset.id,
      event: event.target.dataset.event,
    })
  );
};

window.dragEnd = (event) => {
  console.log("dragEnd", event);
  event.currentTarget.classList.remove("drag-ghost");
};

window.startResizeUp = (event) => {
  console.log("startResizeUp", event);
};
