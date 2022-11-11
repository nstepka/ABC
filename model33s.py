import datetime
from email.policy import default
from unittest.util import _MAX_LENGTH

from django.db import models


class address(models.Model):
    address_id = models.AutoField(primary_key=True)
    state = models.CharField(max_length=100, blank=False, default='')
    address_id = models.CharField(max_length=45, blank=False, default='')
    address_line_1 = models.CharField(max_length=100, blank=False, default='')
    address_line_2 = models.CharField(max_length=100, blank=True, default='')
    country = models.CharField(max_length=45, blank=False, default='')
    postal_code = models.CharField(max_length=45, blank=False, default='')
    city = models.CharField(max_length=45, blank=True, default='')
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class contact(models.Model):
    contact_id = models.AutoField(primary_key=True)
    email_address = models.CharField(max_length=45, blank=False, default='')
    phone_number = models.CharField(max_length=20, blank=False, default='')
    first_name = models.CharField(max_length=50, blank=False, default='')
    last_name = models.CharField(max_length=50, blank=False, default='')
    middle_name = models.CharField(max_length=45, blank=False, default='')
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class abc_client(models.Model):
    abc_client_id = models.AutoField(primary_key=True)
    client_name = models.CharField(max_length=100, blank=False, default='')
    address = models.ForeignKey(address, on_delete=models.CASCADE)
    contacts = models.ManyToManyField(contact)
    company_address_id = models.IntegerField(blank=False)
    phone_number = models.CharField(max_length=45, blank=False, default='')
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class storage_type(models.Model):
    storage_type_id = models.AutoField(primary_key=True)
    type_name = models.CharField(max_length=45, blank=False, default='')
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class inventory(models.Model):
    inventory_id = models.AutoField(primary_key=True)
    abc_client_id = models.ForeignKey(abc_client, on_delete=models.CASCADE)
    inventory_name = models.CharField(max_length=45, blank=False, default='')
    storage_type_id = models.ForeignKey(storage_type, on_delete=models.CASCADE)
    max_item_capacity = models.BigIntegerField(blank=False)
    address = models.ForeignKey(address, on_delete=models.CASCADE)
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class resource_type(models.Model):
    resource_type_id = models.AutoField(primary_key=True)
    type_name = models.CharField(max_length=45, blank=False, default='')
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class abc_resource(models.Model):

    abc_resource_id = models.AutoField(primary_key=True)
    inventory_id = models.ForeignKey(inventory, on_delete=models.CASCADE)
    resource_type_id = models.ForeignKey(
        resource_type, on_delete=models.CASCADE)
    resource_name = models.CharField(max_length=45, blank=False, default='')
    max_number_of_resources = models.BigIntegerField(blank=False)
    current_number_of_resources = models.BigIntegerField(blank=False)
    created_by = models.CharField(max_length=45, blank=False, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
    modified_by = models.CharField(max_length=45, blank=True, default='')
    modified_date = models.DateTimeField(auto_now_add=True, blank=True)
    is_deleted = models.BooleanField(default=False)


class access_log(models.Model):
    access_log_id = models.AutoField(primary_key=True)
    username = models.CharField(max_length=45, blank=True, default='')
    action = models.CharField(max_length=45, blank=True, default='')
    table_name = models.CharField(max_length=45, blank=True, default='')
    field_name = models.CharField(max_length=45, blank=True, default='')
    screen_name = models.CharField(max_length=45, blank=True, default='')
    created_date = models.DateTimeField(auto_now_add=True, blank=True)
