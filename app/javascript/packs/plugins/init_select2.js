import 'select2'
import 'select2/dist/css/select2.css';

const initSelect2 = () => {
  const select_user_role = $('#user_role');

  select_user_role.select2({
    placeholder: "Sélectionner le role"
  });
}

export { initSelect2 };
