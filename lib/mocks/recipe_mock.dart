const RECIPES_MOCK = [
  {
    "imageUrl": "assets/images/recette-pancake.png",
    "avatarUrl": "assets/images/avatar1.png",
    "author": "Fang Patissier",
    "difficulty": 1,
    "title": "Pancake Soufflé",
    "description":
        "Les fluffy pancakes, une recette qui nous vient du pays du soleil levant, le Japon. Des pancakes légers, soufflés et moelleux comme on en voit peu !",
    "utensils": [
      {
        "leading": "assets/images/leading/poele_non_adhesive.png",
        "title": "Poêle anti-adhésive",
      },
      {
        "leading": "assets/images/leading/fouet.png",
        "title": "Fouet ou batteur électrique",
      },
    ],
    "steps": [
      {
        "imageUrl": "assets/images/pancake-step-1.png",
        "title": "Mettre tous les ingredients",
        "description": "Verser le lait, l’huile, et bien mélanger au fouet.",
        "help": {
          "title": "Comment éviter les grumeaux",
          "content":
              "Il est nécessaire d’ajouter le lait très progressivement dans la pâte afin que la farine ait le temps de l’assimiler. Il est conseillé de verser en 4 ou 5 fois sans jamais s'arrêter de fouetter.",
          "videoSource":
              "https://github.com/Betsara-MARCELLIN/video_test/raw/main/no-grumeaux.mp4",
          "videoTitle": "Comment éviter les grumeaux",
        },
        "timeEstimated": 3,
        "overallRemainingTimeFromHere": 48,
        "ingredients": [
          {
            "leading": "assets/images/leading/oeuf.png",
            "title": "Oeufs",
            "subtitle": "4"
          },
          {
            "leading": "assets/images/leading/farine.png",
            "title": "Farine",
            "subtitle": "70g"
          },
          {
            "leading": "assets/images/leading/poudre_lever.png",
            "title": "Poudre à lever",
            "subtitle": "1 cuillère à café"
          },
        ],
      },
      {
        "imageUrl": "assets/images/pancake-step-2.png",
        "title": "Mélanger tout",
        "description":
            "Ajouter l’essence de vanille. Bien fouetter jusqu’à obtention d’un mélange blanchi et mousseux.",
        "timeEstimated": 10,
        "overallRemainingTimeFromHere": 45,
        "help": {
          "title": "Comment éviter les grumeaux",
          "content":
              "Il est nécessaire d’ajouter le lait très progressivement dans la pâte afin que la farine ait le temps de l’assimiler. Il est conseillé de verser en 4 ou 5 fois sans jamais s'arrêter de fouetter.",
          "videoSource":
              "https://github.com/Betsara-MARCELLIN/video_test/raw/main/no-grumeaux.mp4",
          "videoTitle": "Comment éviter les grumeaux",
        },
        "ingredients": [
          {
            "leading": "assets/images/leading/extrait_vanille.png",
            "title": "Extrait de vanille liquide",
            "subtitle": "1 cuillère à café"
          },
          {
            "leading": "assets/images/leading/lait.png",
            "title": "Lait",
            "subtitle": "4 cuillères à soupe"
          },
          {
            "leading": "assets/images/leading/farine.png",
            "title": "Farine",
            "subtitle": "10g"
          },
        ],
      },
      {
        "imageUrl": "assets/images/pancake-step-3.png",
        "title": "Blanc en neige",
        "description":
            "Monter les blancs en neige en ajoutant le sucre progressivement.",
        "timeEstimated": 15,
        "overallRemainingTimeFromHere": 35,
        "ingredients": [
          {
            "leading": "assets/images/leading/sucre.png",
            "title": "Sucre",
            "subtitle": "50g"
          },
        ],
      },
      {
        "imageUrl": "assets/images/pancake-step-4.png",
        "title": "Mélanger soigneusement",
        "timeEstimated": 5,
        "overallRemainingTimeFromHere": 10,
        "description":
            "Une fois les blancs en neige montés, il faut les verser soigneusement dans la pâte et mélanger doucement.",
        "ingredients": [],
      },
      {
        "imageUrl": "assets/images/pancake-step-5.png",
        "title": "La cuisson",
        "timeEstimated": 5,
        "overallRemainingTimeFromHere": 5,
        "description":
            "Verser, à l’aide d’une poche à pâtisserie, la pâte dans la poêle de manière à obtenir des petits cylindres. Couvrir la poêle, laisser cuire 3 à 4 minutes en fonction du feu. Les pancakes doivent dorer.",
        "ingredients": [],
      },
    ]
  }
];
