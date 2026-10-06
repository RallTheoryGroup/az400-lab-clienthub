using Azure.Identity;
using Microsoft.FeatureManagement;
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddHealthChecks();

var endpoint = builder.Configuration["Endpoints:AppConfiguration"]
    ?? throw new InvalidOperationException("App Configuration endpoint is required.");
builder.Configuration.AddAzureAppConfiguration(options =>
    options.Connect(new Uri(endpoint), new DefaultAzureCredential())
        .UseFeatureFlags(flags => flags.SetRefreshInterval(TimeSpan.FromSeconds(30))));
builder.Services.AddAzureAppConfiguration();
builder.Services.AddFeatureManagement();

var app = builder.Build();
app.UseAzureAppConfiguration();
// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.MapHealthChecks("/health");
app.MapGet("/version", () => Results.Ok(new
{
    application = "ClientHub",
    version = System.Reflection.Assembly.GetExecutingAssembly()
        .GetCustomAttributes(typeof(System.Reflection.AssemblyInformationalVersionAttribute), false)
        .Cast<System.Reflection.AssemblyInformationalVersionAttribute>()
        .Single().InformationalVersion.Split('+')[0]
}));

app.MapGet("/feature-demo", async (IFeatureManager features) =>
    Results.Ok(new
    {
        experience = await features.IsEnabledAsync("EnhancedClientSummary")
            ? "enhanced" : "standard"
    }));

app.Run();
