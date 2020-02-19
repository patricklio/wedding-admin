import 'select2'
import 'select2/dist/css/select2.css';

const initSelect2 = () => {
  const select_user_role = $('#user_role');
  const select_joboperation_operation = $('#joboperation_operation_id');
  const select_jobpart_part = $('#jobpart_part_id');

  select_user_role.select2({
    placeholder: "Sélectionner le role"
  });

  select_joboperation_operation.select2({
    placeholder: "selectionner une tâche",
    tags: true,
    casesensitive: false
  });

  select_jobpart_part.select2({
    placeholder: "selectionner une pièce",
    tags: true,
    casesensitive: false
  });
};

export { initSelect2 };
