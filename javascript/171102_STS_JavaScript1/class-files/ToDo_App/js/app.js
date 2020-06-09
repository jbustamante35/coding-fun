/*
Global Variables
*/
///////////////////////////////////////////////////////
// Get incomplete-tasks variable ID from main document to edit ToDo items 
var incompleteTasksHolder = document.getElementById("incomplete-tasks"); 

// Get completed-tasks variable ID from main document to add action to checkBox 
var completedTasksHolder = document.getElementById("completed-tasks");

// Get item in new-task object 
var taskInput = document.getElementById("new-task");

// Get all button objects and get first element (indexed at 0) 
var addButton = document.getElementsByTagName("button")[0];

// Some other function for later 


///////////////////////////////////////////////////////


/*
Functions
*/
///////////////////////////////////////////////////////
// new task list item
var createNewTaskElement = function(taskString) {

    // create list item
    var listItem = document.createElement("li");

    // input (checkbox)
    var checkBox = document.createElement("input"); // checkbox

    // label
    var label = document.createElement("label");

    // input (text)
    var editInput = document.createElement("input"); // text

    // button.edit
    var editButton = document.createElement("button");

    // button.delete
    var deleteButton = document.createElement("button");

    // Each element needs to be modified
    checkBox.type = "checkBox";
    editInput.type = "text";

    editButton.innerText = "Edit";
    editButton.className = "edit";
    deleteButton.innerText = "Delete";
    deleteButton.className = "delete";

    label.innerText = taskString;

    // Each element needs to be appended
    listItem.appendChild(checkBox);
    listItem.appendChild(label);
    listItem.appendChild(editInput);
    listItem.appendChild(editButton);
    listItem.appendChild(deleteButton);

    return listItem;
}

// add a new task
// Code to describe addButton function 
var addTask = function() { 
	console.log("trying to add task"); 
	
	// Add element in taskInput.value (text box) 
	if (taskInput.value !== "") {
		var listItem = createNewTaskElement(taskInput.value); 
		
		// Add new item to completed-tasks object 
		incompleteTasksHolder.appendChild(listItem);
		
		// Add event handles to new item in completed-tasks object 
		bindTaskEvents(listItem, taskCompleted); 
		
		// Clear input box 
		taskInput.value = ""; 
	}
	// Warn if text box is empty 
	else {
		alert("Please enter a ToDo item");
	}
}

  
// Edit an existing task
var editTask = function() {
    console.log("edit task...");

    var listItem = this.parentNode;

    var editInput = listItem.querySelector("input[type=text]");
    var label = listItem.querySelector("label");
    var editButton = listItem.querySelector("button.edit");

    var containsClass = listItem.classList.contains("editMode");

    // if the class of parent is .editMode
    if (containsClass) {
        // switch from .editMode
        // label text become input's value
        label.innerText = editInput.value;
        editButton.innerText = "Edit";
    }
    else {
        // switch to .editMode
        // input value becomes the label's text
        editInput.value = label.innerText;
        editButton.innerText = "Save";
    }

    // toggle .editMode on parent
    listItem.classList.toggle("editMode");
}

// Delete an existing task
var deleteTask = function() {
    console.log("delete task...");

    var listItem = this.parentNode;
    var ul = listItem.parentNode;

    // remove the parent list item from the ul
    ul.removeChild(listItem);
}

// Mark a task as complete
var taskCompleted = function() {
    console.log("task complete...");

    // append the task list item to the #completed-tasks
    var listItem = this.parentNode;
    completedTasksHolder.appendChild(listItem);
    bindTaskEvents(listItem, taskIncomplete);
}

// Mark a task as incomplete
var taskIncomplete = function() {
    console.log("task incomplete...");

    // append the task list item to the #incomplete-tasks
    var listItem = this.parentNode;
    incompleteTasksHolder.appendChild(listItem);
    bindTaskEvents(listItem, taskCompleted);
}

var bindTaskEvents = function(taskListItem, checkBoxEventHandler) {
    console.log("bind list item events");

    // select taskListItem's children
    var checkBox = taskListItem.querySelector("input[type=checkbox]");
    var editButton = taskListItem.querySelector("button.edit");
    var deleteButton = taskListItem.querySelector("button.delete");

    // bind editTask to edit button
    editButton.onclick = editTask;

    // bind deleteTask to delete button
    deleteButton.onclick = deleteTask;

    // bind checkBoxEventHanlder to checkbox
    checkBox.onchange = checkBoxEventHandler;
	
}

// check if the listItem is in edit mode
var checkForEditMode = function(listItem) {
    console.log("checking if the list item is in edit mode");

    var editButton = listItem.querySelector("button.edit");
    var isInEditMode = listItem.classList.contains("editMode");

    // if it is in edit mode
    if (isInEditMode) {
        editButton.innerText = "Save";
    }

    // not in edit mode
    else {
        editButton.innerText = "Edit";
    }
}
///////////////////////////////////////////////////////


/*
Execution Start
*/
///////////////////////////////////////////////////////
// set the click handler to the addTask function
// When user "click" event (standard js event handle) 
addButton.addEventListener("click", addTask);

// cycle over the incompleteTasksHolder ul list items
for (var i=0; i<incompleteTasksHolder.children.length; i++) {
    // bind events to list item's children (taskCompleted)
    var listItem = incompleteTasksHolder.children[i];
    bindTaskEvents(listItem, taskCompleted);
    checkForEditMode(listItem);
}

// Bind button events to Completed Tasks box 
// cycle over the completeTasksHolder ul list items
for (var j = 0; j < completedTasksHolder.children.length; j++) {
	var listItem = completedTasksHolder.children[j];
	
	// Bind Incomplete Tasks button events 
	bindTaskEvents(listItem, taskIncomplete); 
	
	// Check if item is in edit mode 
	checkForEditMode(listItem); 
	
}
    // bind events to list item's children (taskIncomplete)

///////////////////////////////////////////////////////