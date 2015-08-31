package com.chaoticneutral.frizider;

import android.app.ListActivity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import android.view.View;
import android.widget.ArrayAdapter;

import com.chaoticneutral.frizider.model.Ingredient;
import com.chaoticneutral.frizider.model.SQLiteHelper;


public class SastojciActivity extends ListActivity
{
    SQLiteHelper db = new SQLiteHelper(this);
    List list;
    ArrayAdapter myAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sastojci);

        //        drop this database if already exists
        db.onUpgrade(db.getWritableDatabase(), 1, 2);

        db.addIngredient(new Ingredient("So"));
        db.addIngredient(new Ingredient("Biber"));
        db.addIngredient(new Ingredient("Kecap"));

        //        get all ingredients
        list = db.getAllIngredients();
        List listName = new ArrayList();



        for (int i = 0; i < list.size(); i++)
        {
            Ingredient ingredient = (Ingredient)list.get(i);
            listName.add(i, ingredient.getName());
        }

        myAdapter = new ArrayAdapter(this, android.R.layout.simple_list_item_1, listName);
        setListAdapter(myAdapter);
    }

}
