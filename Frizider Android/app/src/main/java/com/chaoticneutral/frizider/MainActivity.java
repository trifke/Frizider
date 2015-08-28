package com.chaoticneutral.frizider;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;


public class MainActivity extends ActionBarActivity
{
    private TextView textViewRaspored;
    private TextView textViewRecepti;
    private TextView textViewFrizider;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textViewRaspored = (TextView)findViewById(R.id.main_textView_raspored);
        textViewRecepti = (TextView)findViewById(R.id.main_textView_recepti);
        textViewFrizider = (TextView)findViewById(R.id.main_textView_frizider);

        textViewRaspored.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Intent intent = new Intent(MainActivity.this, RasporedActivity.class);
                startActivity(intent);
            }
        });

        textViewRecepti.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Intent intent = new Intent(MainActivity.this, ReceptiActivity.class);
                startActivity(intent);
            }
        });

        textViewFrizider.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Intent intent = new Intent(MainActivity.this, FriziderActivity.class);
                startActivity(intent);
            }
        });
    }


}
