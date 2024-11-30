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
import Hooks from "./hooks";

window.dragStartJira = (event) => {
  const target = event.currentTarget;
  event.dataTransfer.setData(
    "application/json",
    JSON.stringify({
      type: "jira",
      key: target.dataset.jiraKey,
      summary: target.dataset.jiraSummary,
    })
  );
};

let dropPreview = null;

window.handleJiraTaskDragOver = (event) => {
  event.preventDefault();
  const container = event.currentTarget;
  const tasksList = container.querySelector("#day-tasks");

  if (!dropPreview) {
    dropPreview = document.createElement("div");
    dropPreview.className = "drop-preview";
    container.classList.add("task-list-dragging");
  }

  // Find the closest task element to insert preview before/after
  const tasks = Array.from(tasksList.children);
  const mouseY = event.clientY;

  let insertBefore = null;
  for (const task of tasks) {
    const rect = task.getBoundingClientRect();
    const midPoint = rect.top + rect.height / 2;

    if (mouseY < midPoint) {
      insertBefore = task;
      break;
    }
  }

  // Remove old preview if it exists
  if (dropPreview.parentNode) {
    dropPreview.remove();
  }

  // Insert preview at the right position
  if (insertBefore) {
    insertBefore.parentNode.insertBefore(dropPreview, insertBefore);
  } else {
    tasksList.appendChild(dropPreview);
  }
};

window.handleJiraTaskDragLeave = (event) => {
  // Only remove if we're leaving the container, not entering a child
  if (!event.relatedTarget?.closest("#day-tasks-container")) {
    if (dropPreview) {
      dropPreview.remove();
      dropPreview = null;
    }
    event.currentTarget.classList.remove("task-list-dragging");
  }
};

window.handleJiraTaskDrop = (event) => {
  event.preventDefault();
  const data = JSON.parse(event.dataTransfer.getData("application/json"));

  if (data.type === "jira") {
    // Clean up preview elements
    if (dropPreview) {
      dropPreview.remove();
      dropPreview = null;
    }
    event.currentTarget.classList.remove("task-list-dragging");

    // Dispatch the event for the hook to handle
    const target = event.currentTarget;
    target.dispatchEvent(
      new CustomEvent("jira-task-drop", {
        bubbles: true,
        detail: data,
      })
    );
  }
};

Hooks.JiraTaskDrop = {
  mounted() {
    this.el.addEventListener("jira-task-drop", (e) => {
      const data = e.detail;
      this.pushEventTo(this.el, "create_jira_task", {
        key: data.key,
        summary: data.summary,
      });
    });
  },
};

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
window.addEventListener("phx:live_reload:attached", ({ detail: reloader }) => {
  // Enable server log streaming to client.
  // Disable with reloader.disableServerLogs()
  reloader.enableServerLogs();
  window.liveReloader = reloader;
});

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
