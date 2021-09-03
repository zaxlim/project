const list = document.getElementById('list');
var parent_id = null;

function getFromChild() {
  var requestOptions = {
    method: "GET",
    redirect: "follow",
  };

  const params = new URLSearchParams(window.location.search);
  var user_id = params.get('id');

  fetch(`http://localhost:3000/contracts/by-child_id?id=${user_id}`, requestOptions)
    .then((response) => response.json())
    .then((data) => {
      data.forEach((item) => {
        addTransactionDOM(item)
      });
    })
    .catch((error) => console.log("error", error));
}

function getFromParent() {
  var requestOptions = {
    method: "GET",
    redirect: "follow",
  };

  const params = new URLSearchParams(window.location.search);
  var user_id = params.get('id');

  fetch(`http://localhost:3000/contracts/by-parent_id?id=${user_id}`, requestOptions)
    .then((response) => response.json())
    .then((data) => {
      data.forEach((item) => {
        addTransactionDOM(item)
      });
    })
    .catch((error) => console.log("error", error));
}

// Add transactions to DOM list
function addTransactionDOM(contract) {
  const txn_item = document.createElement('li');

  txn_item.classList.add('plus'); // <li class="plus">
  txn_item.innerHTML = `
  ${contract.c_description}  <span> $ ${Math.abs(
    contract.c_value
  )}</span> 
  `;

  list.appendChild(txn_item);
}

async function createContract() {
  var myHeaders = new Headers();
  myHeaders.append("Content-Type", "application/json");

  // Get the query parameters from URL, e.g. http://localhost:3000/?id=X will retrieve "id=X"
  const params = new URLSearchParams(window.location.search);
  // This will get the value of the user ID
  var user_id = params.get('id');

  // First we need to get the user record via API
  await fetch(`http://localhost:3000/user?id=${user_id}`, requestOptions)
  .then((response) => response.json())
  .then((data) => {
    // Get the parent ID from the user record
    parent_id = data[0].parent_id;
  })
  .catch((error) => console.log("error", error));

  console.log(parent_id);
  var is_parent = false;

  if(parent_id == null) {
    parent_id = user_id;
    is_parent = true;
    var dropdown = document.getElementById("child_select");
    var child_id = dropdown.options[dropdown.selectedIndex].value;
    user_id = child_id;
    console.log("Parent:"+parent_id);
  }

  // Populate this data from e.g. form.
  var raw = JSON.stringify({
    c_description: document.getElementById("contract_desc").value,
    c_value: document.getElementById("contract_value").value,
    child_id: user_id,
    parent_id: parent_id,
    status_id:1,
  });

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
  };

  fetch("http://localhost:3000/contracts/add", requestOptions)
    .then((response) => response.text())
    .catch((error) => console.log("error", error));

  while(list.firstChild) list.removeChild(list.firstChild);
  if(!is_parent)
    getFromChild();
  else
    getFromParent();

  document.getElementById("contract_desc").value = ''
  document.getElementById("contract_value").value = ''
}


function deleteData() {
  let id = document.getElementById("idToDelete").value;
  fetch(`http://localhost:3000/products/delete/by-id?id=${id}`, {
    method: "DELETE",
  })
    .then((response) => response.text())
    .then((response) => $(".mypanel").html(response))
    .catch((error) => console.log(error));
}

function postData() {
  var myHeaders = new Headers();
  myHeaders.append("Content-Type", "application/json");

  // Populate this data from e.g. form.
  var raw = JSON.stringify({
    type: 0,
    name: "dixant mittal",
    email: "dixant@email.com",
    tolerance: 0.5,
    wallet: 100000,
  });

  var requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: raw,
  };

  fetch("http://localhost:3000/customer/add", requestOptions)
    .then((response) => response.text())
    .then((result) => $(".mypanel").html(result))
    .catch((error) => console.log("error", error));
}
