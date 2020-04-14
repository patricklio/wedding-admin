class Course < ApplicationRecord

    validates :title,
            presence: {
                message: "Le titre  est obligatoire"
            },
            length: {
                minimum: 5,
                message: "le titre est trop court"
            }

end
