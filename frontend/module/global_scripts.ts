// SPDX-License-Identifier: GPL-3.0-or-later
// OCR wordmark with stock OpenProject header logo; glue workbench when configured.

const OCR_HOME = "https://openclimaterisk.com";
const MODULE = "Open Climate Risk";

function mountOcrOpenProjectCobrand(): void {
  document.querySelectorAll(".op-logo:not(.ocr-cobrand-ready)").forEach((el) => {
    const host = el as HTMLElement;
    const opLink = host.querySelector<HTMLAnchorElement>(".op-logo--link");
    if (!opLink) {
      return;
    }

    const ocr = document.createElement("a");
    ocr.className = "ocr-cobrand-mark";
    ocr.href = OCR_HOME;
    ocr.title = "Open Climate Risk";
    ocr.setAttribute("aria-label", "Open Climate Risk");

    const withLabel = document.createElement("span");
    withLabel.className = "ocr-cobrand-with";
    withLabel.setAttribute("aria-hidden", "true");
    withLabel.textContent = "with";

    host.insertBefore(withLabel, opLink);
    host.insertBefore(ocr, withLabel);
    host.classList.add("ocr-cobrand-ready");

    // Light OCR header — use OP's high-contrast (dark) logo asset, not white_big.
    opLink.classList.add("op-logo--link_high_contrast");
  });
}

function glueWorkbenchUrl(): string {
  const i18n = (window as unknown as { I18n?: { t?: (key: string) => string } }).I18n;
  return i18n?.t?.("js.open_climate_risk.glue_workbench_url")?.trim() || "";
}

function addGlueWorkbenchLink(): void {
  const url = glueWorkbenchUrl();
  if (!url) {
    return;
  }
  const menu = document.querySelector(".op-app-menu");
  if (!menu || document.getElementById("ocr-glue-workbench")) {
    return;
  }
  const li = document.createElement("li");
  li.id = "ocr-glue-workbench";
  li.className = "op-app-menu--item hidden-for-mobile";
  li.innerHTML = `<a class="op-app-menu--item-action" href="${url}" title="${MODULE} workbench">
    <span class="op-app-menu--item-title">${MODULE}</span>
  </a>`;
  menu.prepend(li);
}

document.addEventListener("DOMContentLoaded", () => {
  mountOcrOpenProjectCobrand();
  addGlueWorkbenchLink();
});