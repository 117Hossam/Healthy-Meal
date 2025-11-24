import 'package:flutter/material.dart';
import 'meals_data.dart';
import 'meal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthy Meal',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = "Breakfast";
  Meal? selectedMeal;

  @override
  Widget build(BuildContext context) {
    final categoryMeals = mealsByCategory[selectedCategory]!;

    return Scaffold(
      appBar: AppBar(title: const Text("Healthy Meal",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),), backgroundColor: Colors.greenAccent,centerTitle: true,),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text("Select Category", style: TextStyle(fontSize: 22,color: Colors.deepPurple,fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            DropdownMenu(
              initialSelection: selectedCategory,
              onSelected: (mealCategory) {
                setState(() {
                  selectedCategory = mealCategory!;
                  selectedMeal = null; 
                });
              },
              dropdownMenuEntries: mealsByCategory.keys.map((category) {
                return DropdownMenuEntry(value: category, label: category);
              }).toList(),
            ),

            const SizedBox(height: 20),
            const Text("Select Meal", style: TextStyle(fontSize: 22,color: Colors.deepPurple, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Column(
              children: categoryMeals.map((meal) {
                return RadioListTile<Meal>(
                  title: Text(meal.name,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600),),

                  subtitle: Text(meal.description),
                  value: meal,
                  groupValue: selectedMeal,
                  onChanged: (Meal? value) {
                    setState(() {
                      selectedMeal = value;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            if (selectedMeal != null) SingleChildScrollView(
                child: Card(
                  color: Colors.greenAccent,
                  margin: const EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(selectedMeal!.name,
                            style: const TextStyle(
                                color: Colors.deepPurple,fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(selectedMeal!.description,),
                        const Divider(),
                        const Text("Ingredients:",
                            style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600)),
                        ...selectedMeal!.ingredients
                            .map((ingredients) => Text("• $ingredients")),
                        const Divider(),
                        const Text("Steps:",
                            style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w600)),
                        ...selectedMeal!.steps.asMap().entries.map(
                                (entries) => Text("${entries.key + 1}. ${entries.value}")),
                      ],
                    ),
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }
}
