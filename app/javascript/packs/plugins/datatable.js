/* Set the defaults for DataTables initialisation */
const initDatatable = () => {
    $.extend(true, $.fn.dataTable.defaults, {
        "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'p i>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {
            "sLengthMenu": "_MENU_",
            "sUrl": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json"
        }
    });
}

/* Default class modification */
const defautlClassModification = () => {
    $.extend($.fn.dataTableExt.oStdClasses, {
        "sWrapper": "dataTables_wrapper form-inline"
    });
}

/* API method to get paging information */
const pagingInfo = () => {
    $.fn.dataTableExt.oApi.fnPagingInfo = function(oSettings) {
        return {
            "iStart": oSettings._iDisplayStart,
            "iEnd": oSettings.fnDisplayEnd(),
            "iLength": oSettings._iDisplayLength,
            "iTotal": oSettings.fnRecordsTotal(),
            "iFilteredTotal": oSettings.fnRecordsDisplay(),
            "iPage": oSettings._iDisplayLength === -1 ?
                0 : Math.ceil(oSettings._iDisplayStart / oSettings._iDisplayLength),
            "iTotalPages": oSettings._iDisplayLength === -1 ?
                0 : Math.ceil(oSettings.fnRecordsDisplay() / oSettings._iDisplayLength)
        };
    };
}

/* Bootstrap style pagination control */
const paginationControl = () => {
    $.extend($.fn.dataTableExt.oPagination, {
        "bootstrap": {
            "fnInit": function(oSettings, nPaging, fnDraw) {
                var oLang = oSettings.oLanguage.oPaginate;
                var fnClickHandler = function(e) {
                    e.preventDefault();
                    if (oSettings.oApi._fnPageChange(oSettings, e.data.action)) {
                        fnDraw(oSettings);
                    }
                };

                $(nPaging).addClass('pagination').append(
                    '<ul>' +
                    '<li class="prev disabled"><a href="#"><i class="material-icons">chevron_left</i></a></li>' +
                    '<li class="next disabled"><a href="#"><i class="material-icons">chevron_right</i></a></li>' +
                    '</ul>'
                );
                var els = $('a', nPaging);
                $(els[0]).bind('click.DT', { action: "previous" }, fnClickHandler);
                $(els[1]).bind('click.DT', { action: "next" }, fnClickHandler);
            },

            "fnUpdate": function(oSettings, fnDraw) {
                var iListLength = 5;
                var oPaging = oSettings.oInstance.fnPagingInfo();
                var an = oSettings.aanFeatures.p;
                var i, ien, j, sClass, iStart, iEnd, iHalf = Math.floor(iListLength / 2);

                if (oPaging.iTotalPages < iListLength) {
                    iStart = 1;
                    iEnd = oPaging.iTotalPages;
                } else if (oPaging.iPage <= iHalf) {
                    iStart = 1;
                    iEnd = iListLength;
                } else if (oPaging.iPage >= (oPaging.iTotalPages - iHalf)) {
                    iStart = oPaging.iTotalPages - iListLength + 1;
                    iEnd = oPaging.iTotalPages;
                } else {
                    iStart = oPaging.iPage - iHalf + 1;
                    iEnd = iStart + iListLength - 1;
                }

                for (i = 0, ien = an.length; i < ien; i++) {
                    // Remove the middle elements
                    $('li:gt(0)', an[i]).filter(':not(:last)').remove();

                    // Add the new list items and their event handlers
                    for (j = iStart; j <= iEnd; j++) {
                        sClass = (j == oPaging.iPage + 1) ? 'class="active"' : '';
                        $('<li ' + sClass + '><a href="#">' + j + '</a></li>')
                            .insertBefore($('li:last', an[i])[0])
                            .bind('click', function(e) {
                                e.preventDefault();
                                oSettings._iDisplayStart = (parseInt($('a', this).text(), 10) - 1) * oPaging.iLength;
                                fnDraw(oSettings);
                            });
                    }

                    // Add / remove disabled classes from the static elements
                    if (oPaging.iPage === 0) {
                        $('li:first', an[i]).addClass('disabled');
                    } else {
                        $('li:first', an[i]).removeClass('disabled');
                    }

                    if (oPaging.iPage === oPaging.iTotalPages - 1 || oPaging.iTotalPages === 0) {
                        $('li:last', an[i]).addClass('disabled');
                    } else {
                        $('li:last', an[i]).removeClass('disabled');
                    }
                }
            }
        }
    });
}

const initDatatableMethods = () => {
    initDatatable();
    defautlClassModification();
    pagingInfo();
    paginationControl();
}

const initComponentDataTable = () => {
  initDatatableMethods();

  /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
  const defaultDom = "ft<'row'<'col-md-12'p i>>";
  const defaultOptions = {
    "sDom": defaultDom,
    "oLanguage": {
      "sLengthMenu": "_MENU_ ",
      "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
    }
  }

  /* Table initialisation */
  $(document).ready(function () {
        const responsiveHelper = undefined;
        const breakpointDefinition = {
        tablet: 1024,
        phone: 480
        };

        const tableElement = $('#component_id');
        const repairoptionCategoriesElement = $('#repairoption_categories_id');
        const repairoptionsElement = $('#repairoptions_id');
        const operationsElement = $('#operations_list');
        const joboperationsElement = $('#joboperations_list');
        const jobpartsElement = $('#jobparts_list');
        const partsElement = $('#parts_list');
        var customersElement = $('#customer_list_id');
        var partnersElement = $('#partners_id');

        tableElement.dataTable({
        "sDom": defaultDom,
        // "sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'p i>>",
        "aaSorting": [],
        "oLanguage": {
            "sLengthMenu": "_MENU_ ",
            "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
        },
        });

        if (repairoptionCategoriesElement.length) {
        repairoptionCategoriesElement.dataTable(defaultOptions);
        }

        if (repairoptionsElement.length){
        const roTable = repairoptionsElement.dataTable(defaultOptions);
        setTimeout(() => {
            initCategoriesFilters(roTable);
        }, 500);
        }

        if (operationsElement.length) {
        operationsElement.dataTable(defaultOptions);
        }

        if (partnersElement.length){
            partnersElement.dataTable({
                "sDom": defaultDom,
                "aaSorting": [[0, 'asc']],
                "oLanguage": {
                "sLengthMenu": "_MENU_ ",
                "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
                },
            });
        }

        if (customersElement) {
            customersElement.dataTable({
                "sDom": defaultDom,
                "oLanguage": {
                    "sLengthMenu": "_MENU_ ",
                    "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
                },
            });
        }
    
        if (joboperationsElement.length) {
        const oTable = joboperationsElement.dataTable(defaultOptions);
        setTimeout(() => {
            initRepairoptionFilters(oTable);
        }, 500);

        /* Add event listener for opening and closing details
            * Note that the indicator for showing which row is open is not controlled by DataTables,
            * rather it is done here
            */
        $(document).on('click', '#joboperations_list tbody td i', function () {
            const tr = $(this).closest("tr");
            const nTr = $(this).parents('tr')[0];
            if (oTable.fnIsOpen(nTr)) {
            /* This row is already open - close it */
            oTable.fnClose(nTr);
            } else {
            /* Open this row */
            oTable.fnOpen(nTr, fnFormatDetails(tr), 'details');
            }
        });
        }

        if (jobpartsElement.length) {
        const oTable = jobpartsElement.dataTable(defaultOptions);
        setTimeout(() => {
            initJoboperationFilters(oTable);
        }, 500);
        }

        if (partsElement.length) {
        partsElement.dataTable(defaultOptions);
        }

        if (customersElement.length) {
        customersElement.dataTable(defaultOptions);
        }
    });
}

const initCategoriesFilters = (oTable) => {
  $.ajax({
    url: "/admin/repairoptions/categories",
    method: 'GET',
    dataType: 'json',
    error: function (xhr, status, error) {
      console.error('AJAX Error: ', status, error);
    },
    success: function (response) {
      if (response.categories.length > 0) {
        initFilters(oTable, response.categories, "repairoptions_id_filter","Toutes les catégories",3)
      }
    }
  });
}

const initRepairoptionFilters = (oTable) => {
  $.ajax({
    url: "/admin/repairoptions",
    method: 'GET',
    dataType: 'json',
    error: function (xhr, status, error) {
      console.error('AJAX Error: ', status, error);
    },
    success: function (response) {

      if (response.repairoptions.length > 0) {
        const names = $.map(response.repairoptions, function (n, i) {
          return [n.name];
        });
        initFilters(oTable, names, "joboperations_list_filter", "Touts les services", 2)
      }
    }
  });
}

const initJoboperationFilters = (oTable) => {
  $.ajax({
    url: "/admin/joboperations",
    method: 'GET',
    dataType: 'json',
    error: function (xhr, status, error) {
      console.error('AJAX Error: ', status, error);
    },
    success: function (response) {

      if (response.joboperations.length > 0) {
        const names = $.map(response.joboperations, function (n, i) {
          return [n.operation_name];
        });
        initFilters(oTable, names, "jobparts_list_filter", "Toutes les tâches", 1)
      }
    }
  });
}

const initFilters = (oTable, data, filterIdSelector, selectAllText, filterColumnId) => {
  let select = '';

  select = '<div class="col-sm-4">';
  select += '<select class="form-control" id="filters" data-init-plugin="select2" >'
  select += '<option value="0" selected="selected">' + selectAllText+ '</option>';

  $.each(data, function (index, item) {
    select += '<option value="' + item + '">' + item + '</option>';
  });

  select += '</select></div>'

  document.getElementById(filterIdSelector).insertAdjacentHTML("afterbegin", select);

  filterChangeListener(oTable,filterColumnId);
}

const filterChangeListener = (oTable, filterColumnId) => {
  $("#filters").on("change", function () {
    if ($(this).val() == 0){
      oTable.api().column(filterColumnId).search('').draw();
    }else{
      oTable.api().column(filterColumnId).search($(this).val()).draw();
    }
  });
}

/* Formating function for row details */
const fnFormatDetails = (tr) => {
  let jobparts = tr.data("parts");
  let sOut = ""

  sOut = "<div>"
  $.each(jobparts, function (key, value) {
    sOut += "<div class = 'row' style = 'padding-left: 50px;'>" + value.part_qty + " x " + value.part_desc + "</div>"
  });
  sOut += "</div>"
  return sOut;
}

export { initComponentDataTable }
