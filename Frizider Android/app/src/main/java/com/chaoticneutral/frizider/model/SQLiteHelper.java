package com.chaoticneutral.frizider.model;

/**
 * Created by apple on 8/28/15.
 */

import java.util.LinkedList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class SQLiteHelper extends SQLiteOpenHelper
{
    //    database version
    private static final int database_VERSION = 1;
    //    database name
    private static final String database_NAME = "RefrigeratorDB";
    private static final String table_INGREDIENT = "ingredients";
    private static final String ingredient_ID = "id";
    private static final String getIngredient_NAME = "name";

    private static final String[] COLUMNS = {ingredient_ID, getIngredient_NAME};

    public SQLiteHelper(Context context)
    {
        super(context, database_NAME, null, database_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db)
    {
        //        SQL statement to create ingrediant table
        String CREATE_INGREDIANT_TABLE = "CREATE TABLE ingrediants ( " + "id INTEGER PRIMARY KEY AUTOINCREMENT, " + "name TEXT )";
        db.execSQL(CREATE_INGREDIANT_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion)
    {
        //        drop ingrediants table if already exists
        db.execSQL("DROP TABLE IF EXISTS ingrediants");
        this.onCreate(db);
    }

    public void addIngrediant(Ingredient ingredient)
    {
        //        get reference of the IngrediantDB database
        SQLiteDatabase db = this.getWritableDatabase();

        //        make values to be inserted
        ContentValues values = new ContentValues();
        values.put(getIngredient_NAME, ingredient.getName());

        //        insert ingrediant
        db.insert(table_INGREDIENT, null, values);

        //        cloase database transaction
        db.close();
    }

    public Ingredient getIngrediant(int id)
    {
        //        get reference of the IngrediantDB database
        SQLiteDatabase db = this.getReadableDatabase();

        //        get ingrediant query
        Cursor cursor = db.query(table_INGREDIENT, COLUMNS, " id = ?", new String[] { String.valueOf(id)}, null, null, null, null);

        //        if results != null, parse the first one
        if (cursor != null)
            cursor.moveToFirst();

        Ingredient ingredient = new Ingredient();
        ingredient.setId(Integer.parseInt(cursor.getString(0)));
        ingredient.setName(cursor.getString(1));

        return ingredient;
    }

    public List getAllIngrediants()
    {
        List ingrediants = new LinkedList();

        //        select ingrediants query
        String query = "SELECT * FROM " + table_INGREDIENT;

        //        get reference of the IngrediantDB database
        SQLiteDatabase db = this.getWritableDatabase();
        Cursor cursor = db.rawQuery(query, null);

        //        parse all results
        Ingredient ingredient = null;
        if (cursor.moveToFirst())
        {
            do
            {
                ingredient = new Ingredient();
                ingredient.setId(Integer.parseInt(cursor.getString(0)));
                ingredient.setName(cursor.getString(1));

                //      Add ingrediant to ingrediants
                ingrediants.add(ingredient);
            }
            while (cursor.moveToNext());
        }

        return ingrediants;
    }

    //    Deleting single ingrediant
    public void deleteIngrediant(Ingredient ingredient)
    {
        //        get reference of the IngrediantDB database
        SQLiteDatabase db = this.getWritableDatabase();

        //        detele ingrediant
        db.delete(table_INGREDIENT, ingredient_ID + " = ?", new String[] { String.valueOf(ingredient.getId()) });
        db.close();
    }

}
