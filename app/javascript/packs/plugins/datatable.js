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
  $.fn.dataTableExt.oApi.fnPagingInfo = function (oSettings) {
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
      "fnInit": function (oSettings, nPaging, fnDraw) {
        var oLang = oSettings.oLanguage.oPaginate;
        var fnClickHandler = function (e) {
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

      "fnUpdate": function (oSettings, fnDraw) {
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
              .bind('click', function (e) {
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

  /* Table initialisation */
  $(document).ready(function () {
    var responsiveHelper = undefined;
    var breakpointDefinition = {
      tablet: 1024,
      phone: 480
    };

    var tableElement = $('#component_id');
    var repairoptionCategoriesElement = $('#repairoption_categories_id');

    var partnersElement = $('#partners_id');
    var repairoptionsElement = $('#repairoptions_id');
    var operationsElement = $('#operations_list');

    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    const defaultDom = "ft<'row'<'col-md-12'p i>>";

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
      repairoptionCategoriesElement.dataTable({
        "sDom": defaultDom,
        "aaSorting": [[0, 'asc']],
        "oLanguage": {
          "sLengthMenu": "_MENU_ ",
          "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
        }
      });
    }

    if (repairoptionsElement.length){

      const roTable = repairoptionsElement.dataTable({
        "sDom": defaultDom,
        "oLanguage": {
          "sLengthMenu": "_MENU_ ",
          "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
        }
      });
      setTimeout(() => {
        initRepairoptionFilters(roTable);
      }, 500);
    }

    if (operationsElement.length) {
      operationsElement.dataTable({
        "sDom": defaultDom,
        "oLanguage": {
          "sLengthMenu": "_MENU_ ",
          "sInfo": "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments"
        },
      });
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

  });
}

const initRepairoptionFilters = (oTable) => {
  let select = '';
  const filterDiv = $("#repairoptions_id_filter");

  $.ajax({
    url: "/admin/repairoptions/categories",
    method: 'GET',
    dataType: 'json',
    error: function (xhr, status, error) {
      console.error('AJAX Error: ', status, error);
    },
    success: function (response) {
      if (response.categories.length > 0){

        select = '<div class="col-sm-4">';
        select += '<select class="form-control" id="filters" data-init-plugin="select2" >'
        select += '<option value="0" selected="selected">Toutes les catégories</option>';

        $.each(response.categories, function (index, category) {
          select += '<option value="' + category + '">' + category+ '</option>';
        });

        select += '</select></div>'

        document.getElementById("repairoptions_id_filter").insertAdjacentHTML("afterbegin", select);

        filterChangeListener(oTable);
      }
    }
  });
}

const filterChangeListener = (oTable) => {
  $("#filters").on("change", function () {
    if ($(this).val() == 0){
      oTable.api().column(3).search('').draw();
    }else{
      oTable.api().column(3).search($(this).val()).draw();
    }
  });
}

export { initComponentDataTable }
