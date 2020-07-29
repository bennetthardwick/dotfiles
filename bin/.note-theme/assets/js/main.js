const FETCHED = {};
Array.from(document.querySelectorAll("a")).forEach((element) => {
  element.addEventListener("mouseenter", function addLink() {
    if (FETCHED[element.href]) {
      return;
    }

    FETCHED[element.href] = true;

    const link = document.createElement("link");
    link.href = element.href;
    link.rel = "prerender";
    document.head.appendChild(link);

    element.removeEventListener("mouseenter", addLink);
  });
});

const params = new URLSearchParams(window.location.search);
let highlight = params.get("highlight");

if (highlight) {
  params.delete("highlight");

  let path = window.location.pathname;

  if (params.toString() !== "?") {
    path += params.toString();
  }

  window.history.replaceState({}, document.title, path);

  highlight = highlight.replace(/%3a/g, ":");

  let first = true;

  Array.from(document.querySelectorAll('a.ref[href="' + highlight + '"]')).forEach(
    (x) => {
      const p = x.parentNode;

      if (first) {
        first = false;
        p.scrollIntoView();
      }

      p.style.background = "rgba(255, 255, 0, 0.25)";
    }
  );
}
