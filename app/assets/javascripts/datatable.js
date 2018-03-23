var dataTable = $('#datatable').DataTable();

document.addEventListener("turbolinks:before-cache", function() {
    if (dataTable !== null) {
        dataTable.destroy();
        dataTable = null;
    }
});
