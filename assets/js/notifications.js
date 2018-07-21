

function createNotification(message) {
  let title = `${message.currency_name} Alert`;
  let options = {
    icon: "/uploads/currency/logo/1/icon32x32.png",
    body: `Value: ${message.value}`
  }
  let notification = new Notification(title, options);
  notification.onclick = () => openWindow(message.url);
}

function openWindow(pageUrl) {
  window.open(pageUrl);
}

export default function notify(message) {

  // Let's check if the browser supports notifications
  if (!("Notification" in window)) {
    alert("This browser does not support desktop notification");
  }
  // Let's check whether notification permissions have already been granted
  else if (Notification.permission === "granted") {
    // If it's okay let's create a notification
    createNotification(message)
  }

  // Otherwise, we need to ask the user for permission
  else if (Notification.permission !== "denied") {
    Notification.requestPermission(function (permission) {
      // If the user accepts, let's create a notification
      if (permission === "granted") {
        createNotification(message)
      }
    });
  }
}