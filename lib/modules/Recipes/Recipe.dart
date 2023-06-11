import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/styles/colors.dart';

class Recipe extends StatelessWidget {
  const Recipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
            title: Text('Recipe'),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image(image: AssetImage('assets/images/1.jpg')),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bechamel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'This classic Egyptian lasagna with béchamel is made with slow-simmered meat ragu, creamy bechamel, Parmigiano Reggiano, and lasagna noodles.',
                              maxLines: 9,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .changeWidgetVisibility(burn: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (AppCubit.get(context).isBurnAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Ingredients: 1 lb box of oven-ready lasagna noodles or homemade lasagna noodles 4 ounces grated Parmigiano Reggiano or parmesan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  " Beef Ragu Sauce: 2 lbs ground beef 90% to 95% lean, 52 ounces blended and strained tomatoes also known as passata, 1 large onion finely diced, 2 carrots finely diced, 2 celery stalks finely diced, 2 tablespoons olive oil, 1 bay leaf, 6 garlic cloves crushed or minced, 10 kalamata olives pit removed and diced, ½ cup red ketchup, salt",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: defaultColor,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Bechamel Sauce:  4 tbs butter, 4 tbs all-purpose flour, 4 cups milk, ½ teaspoon ground nutmeg, salt",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  " Serving: 1/12 | Calories: 437kcal",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: defaultColor,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Carbohydrates: 42g | Protein: 29g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Fat: 17g | Saturated Fat: 9g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: defaultColor,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Polyunsaturated Fat: 8g | Trans Fat: 0g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Cholesterol: 126mg | Sodium: 368mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Fiber: 4g | Sugar: 9g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/images/2.jpg')), //wound
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Sambousek',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Beef sambousek Egyptian-style, flavored with tangy pomegranate molasses folded into perfect triangles and fried until golden brown. This beef samosa appetizer is freezer-friendly and delicious.',
                              maxLines: 11,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .changeWidgetVisibility(bleeding: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (AppCubit.get(context).isBleedingAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Ingredients:  1 packet Sambousk pastry around 30 sheets, 1 lb lean ground beef, 1 large onion chopped, 2 tablespoon pomegranate molasses, 1 tablespoon olive oil, 1 teaspoon Egyptian 7 spices, 1 teaspoon salt, 1 teaspoon black pepper, oil for frying",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  " Serving: 1 sambousek | Calories: 170kcal",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text(
                                      "Carbohydrates: 18g | Protein: 9g",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "Fat: 7g | Saturated Fat: 1.5g",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: defaultColor,
                                          ),
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.blueAccent,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                          "Polyunsaturated Fat: 5.5g | Trans Fat: 0g",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue[800],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Cholesterol: 15mg | Sodium: 230mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 13,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Fiber: 2g | Sugar: 1g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[800],
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/images/3.jpg')),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Chicken Shawarma',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Crispy baked chicken wings with shawarma seasoning and toum garlic dipping sauce are the best thing since the invention of chicken shawarma.',
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .changeWidgetVisibility(poisoning: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (AppCubit.get(context).isPoisoningAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Ingredients: 4 pounds chicken wings about 25 to 30 wings, 1½ tablespoon dry shawarma seasoning, salt to taste",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Serving: 7wings | Calories: 544kcal | Protein: 45g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Fat: 39g | Saturated Fat: 11g | Polyunsaturated Fat: 8g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Monounsaturated Fat: 16g | Trans Fat: 0.5g | Cholesterol: 189mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Sodium: 179mg | Potassium: 382mg | Vitamin A: 360IU",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Vitamin C: 2mg | Calcium: 29mg | Iron: 2mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/images/4.jpg')),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Koshari',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Koshari is a hearty vegan meal of lentil rice, chickpeas, spicy vinegar tomato sauce, pasta, and fried onions. This Egyptian koshari recipe is an authentic family recipe.',
                              maxLines: 9,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context).changeWidgetVisibility(
                                    Resuscitation: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (AppCubit.get(context).isResuscitationAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Ingredients:  Chickpeas, Fried Onions, salt to taste, Fresh Red Sauce (Optional), salt and pepper to taste, Koshari Lentil Rice, Pasta, Traditional Koshari Red Sauce",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Serving: 3cups | Calories: 528kcal | Carbohydrates: 90g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Protein: 58g | Fat: 12g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Saturated Fat: 2g | Polyunsaturated Fat: 10g | Trans Fat: 0g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Cholesterol: 0mg | Sodium: 161mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Fiber: 28g | Sugar: 6g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(image: AssetImage('assets/images/5.jpg')),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Kofta',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: defaultColor,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Kofta is skewered minced meat kabobs that are often grilled, but can also be baked or pan-roasted.',
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(),
                            ),
                            SizedBox(height: 10),
                            IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .changeWidgetVisibility(Asthma: true);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 35,
                                color: defaultColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (AppCubit.get(context).isAsthmaAidVisible)
                    Card(
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Ingredients:  2.2 lbs minced meat (beef or lamb) 85% to 90% fat content, 2 medium-sized onions, chopped, 3 cloves garlic minced, 1 cup chopped fresh parsley, 1 teaspoon Lebanese 7 spices, 1 teaspoon allspice, ½ teaspoon ground cinnamon, 2 teaspoons salt, 2 tablespoons ghee or butter",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Serving: 4skewers | Calories: 416kcal | Carbohydrates: 4g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Protein: 31g | Fat: 30g | Saturated Fat: 13g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Polyunsaturated Fat: 17g | Trans Fat: 0g | Cholesterol: 110mg",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.black,
                                  size: 10,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Text(
                                  "Sodium: 878mg | Fiber: 1g | Sugar: 2g",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
