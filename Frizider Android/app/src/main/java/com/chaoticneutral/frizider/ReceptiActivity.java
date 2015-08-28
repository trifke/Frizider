package com.chaoticneutral.frizider;

import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;


public class ReceptiActivity extends ActionBarActivity
{
    private TextView textViewAdd;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recepti);

        textViewAdd = (TextView)findViewById(R.id.recepti_textView_add);

        textViewAdd.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Intent intent = new Intent(ReceptiActivity.this, NoviReceptiActivity.class);
                startActivity(intent);
            }
        });
    }

}
