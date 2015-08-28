package com.chaoticneutral.frizider.model;

/**
 * Created by apple on 8/28/15.
 */
public class Ingredient
{

    private int id;
    private String name;

    public Ingredient()
    {

    }

    public Ingredient(String name)
    {
        super();
        this.name = name;
    }

    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Override

    public  String toString()
    {
        return "Ingredient [id = " + id + "name = " + name + "]";
    }

}
